## Extras

### Macros plugin

https://github.com/fralau/mkdocs_macros_plugin
```
pip install mkdocs-macros-plugin
```

```

plugins:
    - search
    - macros

```

**mkdocs-macros-plugin** is a plugin that makes it easier for contributors
of an [MkDocs](https://www.mkdocs.org/) website to produce richer and more beautiful pages. It transforms the markdown pages
into [jinja2](https://jinja.palletsprojects.com/en/2.10.x/) templates
that use **variables**, calls to **macros** and custom **filters**.

Regular **variables** can be defined in four ways:

  1. global (for designers of the website): in the `mkdocs.yml` file,
    under the `extra` heading
  1. global(for contributors): in external yaml definition files
  1. global (for programmers): in a `main.py` file (Python),
    by adding them to a dictionary
  1. local (for contributors): in the markdown file, with a `{%set variable = value %}`
 statement


Similarly programmers can define **macros** and **filters**,
as Python functions in the `main.py` file, which the users will then be able to
use without much difficulty, as jinja2 directives in the markdown page.

You can leverage the power of Python in markdown thanks to jinja2
by writing this :

```markdown
The unit price of product A is {{ unit_price }} EUR.
Taking the standard discount into account,
the sale price of 50 units is {{ price(unit_price, 50) }} EUR.
```

If you defined a `price()` function, this could translate into:

```
The unit price of product A is 10.00 EUR.
Taking the standard discount into account,
the sale price of 50 units is 450.00 EUR.
```

> The result of a macro can be **HTML code**:
this makes macros especially useful
to make custom extensions to the syntax of markdown, such as buttons,
calls to email, embedding YouTube videos, etc.

It is possible to use the wide range of facilities provided by
[Jinja2 templates](http://jinja.pocoo.org/docs/2.10/templates/).

### MKNotebooks

https://github.com/greenape/mknotebooks

mknotebooks is a plugin for [MkDocs](https://mkdocs.org), which makes it more convenient to include [Jupyter](https://jupyter.org) notebooks in your project documentation.

```
pip install mknotebooks
```

#### Usage

Simply include any notebooks you want to use in the docs source directory, and add mknotebooks to the plugin section of your `mkdocs.yml` as follows:

```
plugins:
  - mknotebooks
```

You can optionally execute the notebooks, by setting `execute: true` in the config, and include a hidden preamble script, to be run before executing any cells using `preamble: "<path/to/your/script>"`. The default cell execution timeout can be overridden by setting `timeout: <timeout>`, where `<timeout>` is an integer number of seconds.
By default, execution will be aborted if any of the cells throws an error, but you can set `allow_errors: true` to continue execution and include the error message in the cell output.

Any static images, plots, etc. will be extracted from the notebook and placed alongside the output HTML.

#### Styling

Mknotebooks applies default styling to improve the appearance of notebook input/output cells and pandas dataframes. If these interfere with any other CSS stylesheets that you're using, you can disable these via the following options.
```
- mknotebooks:
   enable_default_jupyter_cell_styling: false
   enable_default_pandas_dataframe_styling: false
```

#### Syntax hightlightting

In order to enable syntax highlighting for code blocks, `pygments` has to be installed and `codehilite` extension has to be enabled in `mkdocs.yml`.

1. Install pygments:

```
pip install Pygments
```

2. Enable `codehilite` extension in `mkdocs.yml`:

```
markdown_extensions:
    - codehilite
```


### Autolinks

https://github.com/midnightprioriem/mkdocs-autolinks-plugin


An MkDocs plugin that simplifies relative linking between documents.

The Autolinks plugins allows you to link to pages and images within your MkDocs site without provided the entire relative path to the file in your document structure.

#### Autolinks Setup 

Install the plugin using pip:

`pip install mkdocs-autolinks-plugin`

Activate the plugin in `mkdocs.yml`:
```yaml
plugins:
  - search
  - autolinks 
```

> **Note:** If you have no `plugins` entry in your config file yet, you'll likely also want to add the `search` plugin. MkDocs enables it by default if there is no `plugins` entry set, but now you have to enable it explicitly.

More information about plugins in the [MkDocs documentation][mkdocs-plugins].


#### Autolinks Usage

To use this plugin, simply create a link that only contains the filename of file you wish to link to.

For example, say you have a document structure like this:

```
docs/
├── guides/
│   ├── onboarding.md
│   └── syntax_guide.md
├── software/
│   ├── git_flow.md
│   └── code_reviews.md
└── images/
    ├── avatar.png
    └── example.jpg
```

Normally, if you want create a link to `git_flow.md` from inside `onboarding.md`, you would need to provide the relative path:

```markdown
# onboarding.md
[Git Flow](../software/git_flow.md)
```

This link is fragile; if someone decides to rearrange the site structure, all of these relative links break. Not to mention having to figure out the relative path.

With the Autolinks plugin, you simply need to provide the filename you wish to link to. The plugin will pre-process all of your markdown files and replace the filename with the correct relative path, given that the file exists in your document structure:

```markdown
# onboarding.md
[Git Flow](git_flow.md)
```

The Autolinks plugin also works with `jpg` and `png` files:

```markdown
# onboarding.md
![Avatar](avatar.png)
```


### Other plugins to consider

https://github.com/spotify/mkdocs-monorepo-plugin
https://github.com/byrnereese/mkdocs-git-committers-plugin
