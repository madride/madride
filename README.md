MADRIDe
=======

Zero-configuration command-line HTTP server with cow super-powers... Basically
it allows you to serve files from the directory where you call it. But in
comparison to other solutions `madride` allows you to write htmls in slim, js in
coffescript and so on... Consider you have following files:

    .
    |- pages/
    |   `- index.html.slim
    |
    `- assets/
        |- app.js.coffee
        `- app.css.sass

You can run `madride pages assets` to start serving these files as:

    /index.html
    /app.js
    /app.css

Similar to the Rails assets pipeline but for html too :))


Future plans
------------

- Attachable plugins via `--with <plugin-name>` option, e.g. `--with bootstrap`
  to allow you easily "attach" bootstrap assets.
- Support for data sources. Prototyping is nice, but it's kinda hard without at
  least mocked data sources. So I plan to add `--data <path_to_yaml_file>`
  option that will allow to specify a file with data available within html
  templates.
