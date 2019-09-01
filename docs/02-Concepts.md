# Concepts

There are some concepts in `purescript-freedom`.
This document explains them.

## Less boilerplate

PureScript has some great UI libraries, but they have some of the following pains:

- A lot of code for updating state through algebraic data type
- A lot of type variables
- Treating effects is cumbersome

While not inherently evil, depending on your chosen package, project, and team, 
you may have shared these same pain points.

`purescript-freedom` looks to relieve these pains with the following approachs:

- The view have constraint that it can't manage user defined local state in it
  - Are you uneasy that it can't manage user defined local state? Please read this doc to the last ;)
- For updating state, Use `reduce` function that can be called specific(e.g. event handler) place and pure state transition function
- Effects like `Aff` can be called with `reduce` in an action

like this:

```purescript
fetchCount = do
  res <- liftAff $ API.get "/count"
  case res of
    Right count ->
      reduce _ { count = count }
    _ ->
      reduce _ { failure = true }
```

See [examples](https://github.com/purescript-freedom/purescript-freedom/blob/master/examples/basic/src/PostEdit/Action.purs) for the actual code.

`purescript-freedom` relieves some pains, but it have new pain.

`purescript-freedom` doesn't yet have a dev tool with time-travel debugging, but it can be created.
However, because the library uses just pure function to update state without going through algebraic data type,
the state transitions of this tool cannot have names when time-travel debugging.


This is trade-off.

## Testable and customizable effect

The following effect example was shown earlier.

```purescript
fetchCount = do
  res <- liftAff $ API.get "/count"
  case res of
    Right count ->
      reduce _ { count = count }
    _ ->
      reduce _ { failure = true }
```

Its type is `FreeT (f state) Aff Unit`, and `f state` is `Functor` that you want.

You use its effect in your whole app.

The transformation of `FreeT` that is used in your app, can be pass to config when initializing the app with `Freedom.run`.

Because it's using `FreeT`, you can customize effect and make testable easy.

Alternatively in simpler cases, `purescript-freedom` provides simple transformation in `Freedom.TransformF.Simple`.

See [an example](https://github.com/purescript-freedom/purescript-freedom/tree/master/examples/user-defined-transformF) that uses user defined transformation and `Functor`.

## Customizable rendering

We often consider where should UI state place.

There are 2 patterns.

- Global state (or outer state): it can be referenced or modified the out of view.
- Local state: it is referenced or modified in its view only. 

And local state splits into 2 patterns.

- Has possibility to become global state, and it depends on your app spec
- Has no possibility to become global state

In my experience, about the former, where it is managed depends on the team's policy.
In a team, the former is managed in local state, In other team, it is managed in global state.
Essentially both are fine.

But judging properly between global and local state is difficult for some developers.
In the process of adding many codes, keeping state in the right place is also difficult in a team that is has various developers.

Also some teams have no policy to manage local state, and as a result code often becomes messy.

In `purescript-freedom`, such UI state is managed in global state only.
Because `purescript-freedom` doesn't want to get people lost when writing codes.

The latter examples are virtual list, CSS transition (with view lifecycle).
In many common virtual DOMs, views that affect the rendering process like these are implemented using local state.
And its local state is completely unrelated to the domain logic.
In such case, we will think "I want to hide implementation details in its view".
But `purescript-freedom` has constraint that it can't manage user defined local state in a view.

Umm...

But `purescript-freedom` has another approach for "has no possibility to become global state".

`purescript-freedom` has mechanism called `OperativeElement`.

Simply put, it is a mechanism that child nodes are not rendered immediately, and allows users to determine the rendering timing and parent node.

By this mechanism, in these example cases (e.g. virtual list, css transition), you can implement a UI, hiding implementation where it should be hidden, without user defined local state.

And its mechanism solves other problems.

Sometimes, we want to ignore DOM hierarchy when render node.
For example, the portal—like the portal of React.js—that is used often for modal and dropdown and so on.
You can implement it with `OperativeElement`.

In summary, it is very useful in `purescript-freedom` that it can't manage user defined local state.

`purescript-freedom` has already some packages used in its mechanism.

Please check [packages](https://github.com/purescript-freedom) if you like.

## CSS with auto-generated class

There is "CSS in JS" in JavaScript world.

Many libraries of "CSS in JS" let people write styles in JavaScript, and such libraries generate class automatically and output styles or manipulate CSSOM.

`purescript-freedom` also has such mechanism, so you can write styles in PureScript.

It evaluates styles gradually as each node is rendered because styles evaluation is incorporated in rendering process.

See an [example](https://github.com/purescript-freedom/purescript-freedom/blob/master/examples/basic/src/PostsIndex/View.purs#L57-L68).

As you can see, write styles with css string, and manage styles close to a view.

`purescript-freedom` doesn't have any motivation to manage typed-CSS, because I think CSS's inherent difficulty doesn't improve when it gets typed.

You can use other CSS libraries if you want.

## Next

Please let me explain the architecture if you like.

[Architecture](https://github.com/purescript-freedom/purescript-freedom/tree/master/docs/03-Architecture.md)
