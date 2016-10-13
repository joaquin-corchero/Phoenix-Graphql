# PhoenixGraphql

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

##Once the site is running:

  * Go here to play with queries[`localhost:4000/graphiql`](http://localhost:4000/graphiql) to run queries like: {

  users {
    name,
    id,
    email
  },
  posts {
    title,
    id,
    body
  }
}

* Run queries directly like:  [`localhost:4000/api?query={posts{title,%20body}}`](http://localhost:4000/api?query={posts{title,%20body}})


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
  * absinthe_plug: https://github.com/absinthe-graphql/absinthe_plug
  * graphql: http://graphql.org/learn/
