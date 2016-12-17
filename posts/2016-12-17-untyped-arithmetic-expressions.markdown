---
title: Untyped Arithmetic Expressions
author: Jonathan Creekmore
email: jonathan@thecreekmores.org
---

I have recently started working my way through the excellent
*Types and Programming Languages (TaPL)* by Benjamin Pierce (expect to
see this name pop up a lot in the future, because I plan on working
through *Software Foundations* by him as well). Since I am also a huge
fan of the Rust programming language, I have started working through
the programming examples in Rust.

Rust is not the best language to write little interpreters in. While it
provides pattern matching, which is really essential for this task, the
borrowing rules force the code to be a bit ugly at times. The first major
code example in the book is an interpreter for untyped arithmetic expressions.
Rust does make it fairly short, so I will reproduce it all here and then
walk through bits of it to explain.

### Untyped Arithmetic Expressions

~~~~~ { .rust .numberLines }
#![feature(box_syntax, box_patterns)]

#[derive(Clone, Debug, PartialEq)]
pub enum Term {
    True,
    False,
    Zero,
    IsZero(Box<Term>),
    Succ(Box<Term>),
    Pred(Box<Term>),
    If(Box<Term>, Box<Term>, Box<Term>),
}

pub fn is_numeric_val(t: &Term) -> bool {
    match *t {
        Term::Zero => true,
        Term::Succ(ref t) => is_numeric_val(t),
        _ => false,
    }
}

pub fn eval1(t: &Term) -> Option<Term> {
    match *t {
        /// True-valued if statement
        Term::If(box Term::True, ref t2, _) => Some(*t2.clone()),
        /// False-valued if statement
        Term::If(box Term::False, _, ref t3) => Some(*t3.clone()),
        /// Evaluate the condition first, then return an if statement
        /// that has the condition evaluated to a true or false
        Term::If(ref cond, ref t2, ref t3) => {
            eval1(cond).map(|boolean| {
                 Term::If(box boolean, box *t2.clone(), box *t3.clone())
            })
        }
        /// Succ(t) means we have to evaluate t first to simplify it, then we
        /// rewrite the term to Succ(evaled)
        Term::Succ(ref t) => eval1(t).map(|evaled| Term::Succ(box evaled)),
        /// The predecessor of Zero is defined as Zero
        Term::Pred(box Term::Zero) => Some(Term::Zero),
        /// The predecessor of the successor of a value is the value itself
        /// (if it was a numeric value to begin with)
        Term::Pred(box Term::Succ(ref nv1)) if is_numeric_val(nv1) => Some(*nv1.clone()),
        /// Pred(t) means we have to evaluate t first to simplify it, then we
        /// rewrite the term to Pred(evaled)
        Term::Pred(ref t) => eval1(t).map(|evaled| Term::Pred(box evaled)),
        /// By definition, the Zero term IsZero.
        Term::IsZero(box Term::Zero) => Some(Term::True),
        /// If the term is numeric and the successor of a value, then it cannot be IsZero
        Term::IsZero(box Term::Succ(ref nv1)) if is_numeric_val(nv1) => Some(Term::False),
        /// If a term evals to Zero, then the term IsZero
        Term::IsZero(ref t) => eval1(t).map(|evaled| Term::IsZero(box evaled)),
        _ => None,
    }
}

pub fn eval(t: &Term) -> Option<Term> {
    Some(eval1(t)
             .and_then(|t| eval(&t))
             .unwrap_or(t.clone()))
}

~~~~~

So, due to Rust's memory management rules, we have to specify when structures are stored on the heap
and when they are just stored in place. In Rust, we can do that by declaring the object to be boxed
with `Box`. So, when we define the `Term` enumeration (lines 4--12), terms that have other terms
embedded in them take the embedded terms as boxes. That leads us to the magic at the very first line.
To be able to pattern match inside of a `Box`, we have to enable the `box_patterns` feature. I chose
to also enable the `box_syntax` feature because it makes the code a bit shorter when creating boxes.
Note that compiler features are not stable, so you have to compile this code with a nightly compiler
to get it to build. I built it on 1.10 initially and recently rebuilt it using 1.13.

The evaluation functions are mostly self-explanatory with the in-line comments I put into place. I want
to make a few general comments, though. Evaluating these terms works mainly like algebraic simplification.
At each step, you look at the pattern and perform the required simplification. The `eval1` function performs
what is described in *TaPL* as a single-step evaluation. It does a single step in the evalution process and
returns a simpler expression. Then, the `eval` function causes that simpler expression to go back through
the `eval1` function again to further simplify it until it cannot be simplified any more. At that point,
`eval1` will return `None`, causing the recursion to terminate and the fully simplified form to be
returned as the answer.

While I did not include them, I wrote several tests to verify that I was evaluating everything correctly.
You can see the Cargo project (including the tests) in the
[arith directory of my tapl repo on Github](https://github.com/jcreekmore/tapl/tree/master/arith).
