## Automatic publishing to gh-pages using github-actions

We will be using 3rd party action https://github.com/peaceiris/actions-gh-pages

You need to do once:

```
ssh-keygen -t rsa -b 4096 -C "$(git config user.email)" -f gh-pages -N ""
# You will get 2 files:
#   gh-pages.pub (public key)
#   gh-pages     (private key)
```

Next, Go to Repository Settings

Go to Deploy Keys and add your public key with the Allow write access
Go to Secrets and add your private key as ACTIONS_DEPLOY_KEY

Now you can add fragment to your github workflow pipeline


```yml

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3.6.1
        with:
          publish_dir: ./site
          deploy_key: ${{ secrets.ACTIONS_DEPLOY_KEY }}
          publish_branch: gh-pages

```

# Extras

# mkdocs-table-reader-plugin

[MkDocs](https://www.mkdocs.org/) plugin that adds a `{{ read_csv('table.csv') }}` markdown tag to directly insert CSV files in a page.

This helps to enable building reproducible reports. For more complex use cases, consider [pheasant](https://pheasant.daizutabi.net/) or [nbconvert](https://tanbro.github.io/mkdocs-nbconvert/).

## Setup

Install the plugin using `pip3`:

```bash
pip3 install mkdocs-table-reader-plugin
```

Next, add the following lines to your `mkdocs.yml`:

```yml
plugins:
  - search
  - table-reader
```

> If you have no `plugins` entry in your config file yet, you'll likely also want to add the `search` plugin. MkDocs enables it by default if there is no `plugins` entry set.

## Usage

In your markdown documents you can now use:

```html
{{ read_csv('path_to_table.csv') }}
```

Where the path is relative to the location of your project's `mkdocs.yml` file.

Under the hood this is basically:

```python
import pandas as pd
df = pd.read_csv('path_to_table.csv')
df.to_markdown(showindex=False)
```

Which means you can pass all parameters of [pandas.read_csv()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html).

### Available readers

The table reader functions implemented from `pandas`:

- `{{ read_csv() }}` passed to [pandas.read_csv()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html).
- `{{ read_table() }}` passed to [pandas.read_table()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_table.html)`.
- `{{ read_fwf() }}` passed to [pandas.read_fwf()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_fwf.html).
- `{{ read_excel() }}` passed to [pandas.read_excel()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_excel.html).

# Macros plugin

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

### mkdocs-redirects

Plugin for [`mkdocs`](https://www.mkdocs.org/) to create page redirects (e.g. for moved/renamed pages).

#### Installing mkdocs-redirects

> **Note:** This package requires MkDocs version 1.0.4 or higher.

Install with pip:

```bash
pip install mkdocs-redirects
```

#### Using mkdocs-redirects

To use this plugin, specify your desired redirects in the plugin's `redirect_maps` setting in your `mkdocs.yml`:

```yaml
plugins:
    - redirects:
        redirect_maps:
            'old.md': 'new.md'
            'old/file.md': 'new/file.md'
            'some_file.md': 'http://external.url.com/foobar'
```

_Note: don't forget that specifying the `plugins` setting will override the defaults if you didn't already have it set! See [this page](https://www.mkdocs.org/user-guide/configuration/#plugins) for more information._

The redirects map should take the form of a key/value pair:

- The key of each redirect is the original _markdown doc_ (relative to the `docs_dir` path).
  - This plugin will handle the filename resolution during the `mkdocs build` process.
    This should be set to what the original markdown doc's filename was (or what it _would be_ if it existed), not the final HTML file rendered by MkDocs
- The value is the _redirect target_. This can take the following forms:
  - Path of the _markdown doc_ you wish to be redirected to (relative to `docs_dir`)
    - This plugin will handle the filename resolution during the `mkdocs build` process.
      This should be set to what the markdown doc's filename is, not the final HTML file rendered by MkDocs
  - External URL (e.g. `http://example.com`)

During the `mkdocs build` process, this plugin will create `.html` files in `site_dir` for each of the "old" file that redirects to the "new" path.
It will produce a warning if any problems are encountered or of the redirect target doesn't actually exist (useful if you have `strict: true` set).

#### `use_directory_urls`

If you have `use_directory_urls: true` set (which is the default), this plugin will modify the redirect targets to the _directory_ URL, not the _actual_ `index.html` filename.
However, it will create the `index.html` file for each target in the correct place so URL resolution works.

For example, a redirect map of `'old/dir/README.md': 'new/dir/README.md'` will result in an HTML file created at `$site_dir/old/dir/index.html` which redirects to `/new/dir/.

Additionally, a redirect map of `'old/dir/doc_name.md': 'new/dir/doc_name.md'` will result in `$site_dir/old/dir/doc_name/index.html` redirecting to `/new/dir/doc_name/`

This mimcs the behavior of how MkDocs builds the site dir without this plugin.


### « Blogs for MkDocs » (MkDocs-Blog-Plugin)

This plugin allows you to host a tiny blog section in your MkDocs site.
Move away, WordPress... well, not really.

#### How does it work ?
It's quite simple. 90% of the work is already done by MkDocs itself.
Each time you will build your MkDocs site or serve it, this plugin will try to find a specific directory in your documentation folder. 
If it finds it, every document and every subdirectory nested in it will be listed in reverse on the navbar. Plus, if you will have too many documents to be 
listed at once, the plugin will try to organize your remaining documents in subfolders.

#### How can I install it ?
You can install it through pip with this command:
```
pip install mkdocs-blog-plugin
```

Then, open your mkdocs.yml configuration file and add these lines:
```
plugins:
    - blog
```
Last but not least, enter you docs folder and create a new subfolder and name it blog. This plugin will try to find blog articles inside this directory.
Then you are ready to begin.

#### How can I add new articles to my blog section ?
Inside docs/blog create a folder for each year you are planning to add new articles. Then, inside each year folder create twelve folders, numbered from 01 to 12 for each month. 
Finally, in each month folder for each day create a corresponding folder but remember to add a leading zero (for example: 08, 09, 10, ...) 
Now, for every article you will go inside the corresponding `year/month/day folder and you will create a new file there. While it is not necessary that you keep this 
strict naming convention, this will help the plugin to understand when your article was made.

For example, this is how I manage my blog folder:

```
docs
├── blog
│   ├── 2019
│   └── 2020
│       ├── 01
│       │   ├── 20
│       │   │   └── first-article.md
│       │   └── 26
│       │       └── second-article.md
│       ├── 02
│       │   ├── 01
│       │   │   └── third_article.md
│       │   └── 09
│       │       └── fourth-article.md
│       └── 03
│           └── 16
│               └── fifth-article.md
└── index.md
```

#### Customizing the plugin

You can customize this plugin by adding some parameters in the mkdocs.yml file, like this:

```
- plugin:
      - blog:
          format: "(%m/%d/%y)"
          text-align: "right"
```

Here is a brief list of every parameters supported by the current version of the plugin:


- folder
This is the section / folder in which we'll try to build our blog
Default value: "blog"

- articles
How many articles do we have to display on our blog at once? More articles will be displayed in the corresponding subsection
Default value: 6 articles

- more-articles
Let's allow our user to slightly customize the "previous articles" section. How do we have to name this section if it will contains more articles? Remember to put a percentage character wherever you want this plugin to insert the number of available articles.
Default value: "More articles (%)"

- pagination
Which name do we have to give to each subsection inside our "more articles" section? Remember to put two percentage characters wherever you want this plugin to insert the actual number page and the total amount of pages made.
Default value: Page % of %"

- display-more-articles
Can we display the previous articles section, or is it better if we hide it?
Default: True

- display-article-date
Can we display the article date in the navbar, or is it better if we hide it?
Default: True

- format
How we have to display an article publication date on our navbar?
You can use these placeholders inside your string:

```
%d = Day
%m = Month
%y = Year (2-digits)
%Y = Year (4-digits)
```

Default value: "[%d/%m]"
- text-align
Do we have to display an article publication date on the left side ("left") or on the right side ("right")?
Default value: "left"


### Other plugins to consider

https://github.com/spotify/mkdocs-monorepo-plugin
https://github.com/byrnereese/mkdocs-git-committers-plugin


### Custom callbacks with mkdocs-simple-hooks

Plugin docs https://github.com/aklajnert/mkdocs-simple-hooks

Let's say you want to copy the `README.md` file to `docs/index.md`. To do that, create a new file, e.g.: `docs/hooks.py`, and put the following function there:

```py
import shutil

def copy_readme(*args, **kwargs):
    shutil.copy("README.md", "docs/index.md")
```

Now, register the hook in your mkdocs.yml:

```yaml
plugins:
  - mkdocs-simple-hooks:
      hooks:
        - on_pre_build: "docs.hooks:copy_readme"
```

Idea for list of hooks can be obtained on  https://www.mkdocs.org/user-guide/plugins/#events
and ideas what you could generally intercept on which level can be obtained from https://github.com/mkdocs/mkdocs/wiki/Event-Based-Plugin-API

event       | vars   | Possible usage
----------- | ------ | --------------
post-config | config | Alter config or prepossessing based on config values
pre-nav     | config, nav-item | Alter/intercept a nav item's creation
post-nav    | config, nav-item, global nav (so far) | Alter a just created nav item
pre-build   | config, global template vars, global nav | Alter global nav, template vars, etc.
pre-page    | config, template, context | Alter single page and/or template
post-page   | config, rendered template | Page specific post-processing
post-build  | config | project wide postprocessing
deploy      | config | provide a deploy script (only fired from deploy command)
pre-serve   | config, server_instance | add addition files/dirs to watcher (only fired from serve command)
