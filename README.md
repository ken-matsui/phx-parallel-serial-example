# ParallelSerial

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Usage

```
$ curl -kL "http://localhost:4000/api/serial/study?q=html" -o /dev/null -w "%{time_total}\n" 2> /dev/null
0.116642
$ curl -kL "http://localhost:4000/api/parallel/study?q=html" -o /dev/null -w "%{time_total}\n" 2> /dev/null
0.035797
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
