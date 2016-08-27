--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Default (def)
import           Data.Monoid (mappend)
import           Hakyll


myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle         = "Technological Musings"
    , feedDescription   = "Thoughts about building software"
    , feedAuthorName    = "Jonathan Creekmore"
    , feedAuthorEmail   = "jonathan@thecreekmores.org"
    , feedRoot          = "http://thecreekmores.org"
    }

deploy :: String
deploy = "git stash && " ++
         "git checkout develop && " ++
         "stack exec thecreekmores-org clean && " ++
         "stack exec thecreekmores-org build && " ++
         "git fetch --all && " ++
         "git checkout -b master --track origin/master && " ++
         "rsync -a --filter='P _site/' --filter='P _cache/' --filter='P .git/' --filter='P .gitignore' --delete-excluded _site/ . && " ++
         "git add -A && " ++
         "git commit -m \"Publish.\" && " ++
         "git push origin master:master && " ++
         "git checkout develop && " ++
         "git branch -D master && " ++
         "git stash pop"

configuration :: Configuration
configuration = def { deployCommand = deploy }

--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith configuration $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= saveSnapshot "rawcontent"
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx `mappend` bodyField "description"
            posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "content"
            renderAtom myFeedConfiguration feedCtx posts

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "rawcontent"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Home"                `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

