---
title: Regular Expression Decoding
author: Jonathan Creekmore
email: jonathan@thecreekmores.org
---

Regular expressions are great. They can be a quick and easy way to extract
substrings of interest from a string. I use the awesome `hyper` crate in my
day job to serve up a web API and I use the `hyper-router` crate to define
all of the routes for the web API using regular expressions. Often times, those
regular expressions are used something like this (stub code borrowed from
[hyper-router](https://github.com/marad/hyper-router)):

~~~~~ { .rust .numberLines }
extern crate hyper;
extern crate hyper_router;
extern crate regex;

use hyper::server::{Server, Request, Response};
use hyper::status::StatusCode;
use hyper::uri::RequestUri;
use hyper_router::{Route, RouterBuilder};
use regex::Regex;

const ENDPOINT: &'static str = r"^/api/(?P<mac>[a-f0-9]{12})/version/(?P<version>[0-9]{14})";

fn get_uri(uri: &RequestUri) -> String {
  // get the uri as a string
}

// INTERESTING BIT IS HERE!!!
fn endpoint_handler(req: Request, res: Response) {
  let uri = get_uri(&req.uri);
  let endpoint_regex = Regex::new(ENDPOINT).unwrap();
  let captures = endpoint_regex.captures(&uri).unwrap()
  let mac = captures.name("mac").unwrap();
  let version_str = captures.name("version").unwrap();
  let version: u64 = version_str.parse().unwrap();

  // Do something with the mac and the version number

  res.send(b"Hello World!").unwrap();
}

fn main() {
  let router = RouterBuilder::new()
    .add(Route::get(ENDPOINT).using(endpoint_handler))
    .build();

  Server::http("0.0.0.0:8080").unwrap()
    .handle(move |request: Request, response: Response| {
      match router.find_handler(&request) {
        Ok(handler) => handler(request, response),
        Err(StatusCode::NotFound) => response.send(b"not found").unwrap(),
        Err(_) => response.send(b"some error").unwrap()
     }
   }).unwrap();
}

~~~~~

That code isn't too terrible, but it is ignoring a lot of error handling for extracting the mac and
version strings from the regular expression, as well as error code for converting that version
string to an actual number. Now, in this case, the unwraps are probably okay since:

* We had to match against the regular expression for the `endpoint_handler` to be called, so
we should successfully get a captures object from applying the regex to the uri.
* Both mac and version will exist.
* The version string will be a number that fits in a u64 because of the regex.

However, the code gets very repetitive. What if we could just do something like this?

~~~~~ { .rust .numberLines }
extern crate regex_decode;
use regex_decode::decode;

#[derive(RustcDecodable)]
struct EndpointUri {
  mac: String,
  version: u64,
}

fn endpoint_handler(req: Request, res: Response) {
  let uri = get_uri(&req.uri);
  let endpoint_regex = Regex::new(ENDPOINT).unwrap();
  let endpoint = decode::<EndpointUri>(&endpoint_regex, &uri).unwrap();

  // Do something with the mac and the version number we got from
  // the endpoint...

  res.send(b"Hello World!").unwrap();
}
~~~~~

That is what the [regex-decode](https://github.com/jcreekmore/regex-decode) crate does for you.
It provides the ability to decode the named capture groups of a regular expression into a struct.
Additionally, it will do type conversions from strings into other primitive types that are defined
in the struct. So, in the above example, it hides away the boilerplate of extracting the named
captures and the type conversion and gives you a single place to check for errors, instead of every
step along the way.

If defining a struct is too heavy-weight for you, just have it decode to a tuple:

~~~~~ { .rust .numberLines }
extern crate regex_decode;
use regex_decode::decode;

fn endpoint_handler(req: Request, res: Response) {
  let uri = get_uri(&req.uri);
  let endpoint_regex = Regex::new(ENDPOINT).unwrap();
  let (mac, version) = decode::<(String, u64)>(&endpoint_regex, &uri).unwrap();

  // Do something with the mac and the version number we got from
  // the endpoint...

  res.send(b"Hello World!").unwrap();
}
~~~~~

In this case, we are not decoding by the names of the capture groups and are instead just grabbing
the captures by position. Plus, that still gives you the type safety that the struct would give you.

You should be able to use any type you want as long as it is `RustcDecodable`. However, recursive types
do not make a whole lot of sense while you are parsing a regular expression, so those are not handled.
Also, I have not figured out a good way to decode tuple structs yet, so the library will emit an error
if you are trying to decode to a tuple struct. But, for the use case of quickly decoding to a simple
struct, the crate works just fine.

