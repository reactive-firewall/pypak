# -*- coding: utf-8 -*-

# sample documentation build configuration file, created by
# sphinx-quickstart on Mon Apr 16 21:22:43 2012.

# Copyright (c) 2012-2024, Mr. Walls

# This file is execfile()d with the current directory set to its containing dir.

# Note that not all possible configuration values are present in this
# autogenerated file.

# All configuration values have a default; values that are commented out
# serve to show the default.

import sys
import os

# Define the branch reference for linkcode_resolve
DOCS_BUILD_REF = os.environ.get("DOCS_BUILD_REF", "stable")
"""
DOCS_BUILD_REF: The Git reference used in the GitHub links generated by linkcode_resolve().
Accepts most git referancees (commit hash or branch name).
Defaults to 'stable', but can be overridden by setting the DOCS_BUILD_REF environment variable.
"""

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
sys.path.insert(0, os.path.abspath(""".."""))
sys.path.insert(1, os.path.abspath("""pak"""))
sys.path.insert(1, os.path.abspath("""tests"""))

# -- General configuration -----------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
needs_sphinx = "7.3"

# Add any Sphinx extension module names here, as strings. They can be extensions
# coming with Sphinx (named 'sphinx.ext.*') or your custom ones.
# for md us 'autodoc2' (pip install sphinx-autodoc2)
# for rst use 'sphinx.ext.autodoc'
extensions = [
	"""sphinx.ext.napoleon""", """autodoc2""", """sphinx.ext.autosectionlabel""",
	"""sphinx.ext.githubpages""", """myst_parser""",
	"""sphinx.ext.autosummary""", """sphinx.ext.doctest""", """sphinx.ext.todo""",
	"""sphinx.ext.linkcode""", """sphinx.ext.viewcode""", """sphinx.ext.intersphinx""",
]

# for md auto-docs
autodoc2_packages = [
	"pak",
	"tests.context",
	"tests",
]

autodoc2_render_plugin = "myst"

# Add any paths that contain templates here, relative to this directory.
templates_path = ["_templates"]

# The suffix of source filenames.
source_suffix = {
	".md": "markdown",
	".txt": "markdown",
	".rst": "restructuredtext",
	".yml": "yaml",
	"Makefile": "makefile",
}

# The encoding of source files. Official sphinx docs recommend utf-8-sig.
source_encoding = "utf-8-sig"

# The master toctree document.
master_doc = "toc"

# General information about the project.
project = "pak"
copyright = "2023-2024, reactive-firewall"

# The version info for the project yo"re documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# The short X.Y version.
version = "v2.0"
# The full version, including alpha/beta/rc tags.
release = "v2.0.0-beta"

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
# language = None

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
# today = ''
# Else, today_fmt is used as the format for a strftime call.
# today_fmt = '%B %d, %Y'
today_fmt = "%Y.%B.%d"

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = [
	"_build", ".github", ".circleci", "codecov_env", ".DS_Store", "**/.git", "dist",
	"../tests/tests/**", "www", "**/docs", "../pak/pak/**", "*~"
]

# The reST default role (used for this markup: `text`) to use for all documents.
# default_role = None

# If true, '()' will be appended to :func: etc. cross-reference text.
add_function_parentheses = True

# If true, the current module name will be prepended to all description
# unit titles (such as .. function::).
add_module_names = True

# sigs should not have backslashes
strip_signature_backslash = True

# If true, sectionauthor and moduleauthor directives will be shown in the
# output. They are ignored by default.
show_authors = True

# The name of the Pygments (syntax highlighting) style to use.
# pygments_style = "default"
pygments_style = "xcode"

# and for dark-mode
# pygments_style_dark ="monokai"
pygments_style_dark = "github-dark"


pygments_options = {
	"""tabsize""": 4,
	"""stripall""": False,
	"""encoding""": "utf-8",
}

pygments_yaml_options = {
	"""tabsize""": 2,
	"""stripall""": True,
	"""encoding""": "utf-8",
}

highlight_options = {
	"default": pygments_options,
	"python": pygments_options,
	"yaml": pygments_yaml_options,
	"makefile": pygments_options,
}

# A list of ignored prefixes for module index sorting.
# modindex_common_prefix = []

# Create table of contents entries for domain objects (e.g. functions, classes, attributes, etc.).
toc_object_entries = True

# -- Options for HTML output ---------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
html_theme = "sphinxawesome_theme"

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
# html_theme_options = {}

# Add any paths that contain custom themes here, relative to this directory.
# html_theme_path = []

# The name for this set of Sphinx documents.  If None, it defaults to
# "<project> v<release> documentation".
# html_title = None

# A shorter title for the navigation bar.  Default is the same as html_title.
html_short_title = "pak Docs"

# The name of an image file (relative to this directory) to place at the top
# of the sidebar.
# html_logo = None

# The name of an image file (within the static path) to use as favicon of the
# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
# html_favicon = None

try:
	from sphinxawesome_theme.postprocess import Icons
	html_permalinks_icon = Icons.permalinks_icon
except Exception:
	html_permalinks_icon = "<span>#</span>"

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ["_static"]

# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
# using the given strftime format.
# html_last_updated_fmt = '%b %d, %Y'
html_last_updated_fmt = today_fmt.strip()

# If true, SmartyPants will be used to convert quotes and dashes to
# typographically correct entities.
# html_use_smartypants = True

# Custom sidebar templates, maps document names to template names.
# html_sidebars = {}

# Additional templates that should be rendered to pages, maps page names to
# template names.
# html_additional_pages = {}

# If false, no module index is generated.
# html_domain_indices = True

# If false, no index is generated.
html_use_index = True

# If true, the index is split into individual pages for each letter.
# html_split_index = False

# If true, links to the reST sources are added to the pages.
# html_show_sourcelink = True

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
# html_show_sphinx = True

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
html_show_copyright = True

# If true, an OpenSearch description file will be output, and all pages will
# contain a <link> tag referring to it.  The value of this option must be the
# base URL from which the finished HTML is served.
# html_use_opensearch = ''

# This is the file name suffix for HTML files (e.g. ".xhtml").
#html_file_suffix = "html"

# Output file base name for HTML help builder.
htmlhelp_basename = "pak_doc"


# -- Options for MyST markdown parser -------------------------------------------
# see https://myst-parser.readthedocs.io/en/latest/syntax/roles-and-directives.html

# be more like GFM with style
myst_enable_extensions = ("tasklist", "strikethrough", "fieldlist")

# for GFM diagrams and interoperability with other Markdown renderers
myst_fence_as_directive = ("mermaid", "suggestion", "note")

# Focus only on github markdown
# myst_gfm_only = True

# how deep should markdown headers have anchors be generated
heading_anchors = 3

# -- Options for napoleon ext --------------------------------------------------

# include __init__ when it has docstrings
napoleon_include_init_with_doc = True

# try to be smarter
napoleon_preprocess_types = True

# -- Options for LaTeX output --------------------------------------------------

latex_elements = {}
# The paper size ('letterpaper' or 'a4paper').
# 'papersize': 'letterpaper',

# The font size ('10pt', '11pt' or '12pt').
# 'pointsize': '10pt',

# Additional stuff for the LaTeX preamble.
# 'preamble': '',
# }

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title, author, documentclass [howto/manual]).
latex_documents = [
	(
		"index",
		"Documentation.tex",
		"pak Documentation",
		"reactive-firewall",
		"manual"
	),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
# latex_logo = None

# For "manual" documents, if this is true, then toplevel headings are parts,
# not chapters.
# latex_use_parts = False

# If true, show page references after internal links.
# latex_show_pagerefs = False

# If true, show URL addresses after external links.
# latex_show_urls = False

# Documents to append as an appendix to all manuals.
# latex_appendices = []

# If false, no module index is generated.
# latex_domain_indices = True


# -- Options for manual page output --------------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
	(
		"index",
		"pak",
		"pak Documentation",
		["reactive-firewall"],
		1
	)
]

# If true, show URL addresses after external links.
# man_show_urls = False


# -- Options for Texinfo output ------------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
	(
		"index",
		"pak",
		"pak Documentation",
		"reactive-firewall",
		"pak",
		"pak Python Module.",
		"Miscellaneous"
	),
]

# Documents to append as an appendix to all manuals.
# texinfo_appendices = []

# If false, no module index is generated.
# texinfo_domain_indices = True

# How to display URL addresses: 'footnote', 'no', or 'inline'.
# texinfo_show_urls = 'footnote'

# -- Link resolver -------------------------------------------------------------

linkcode_url_prefix = str(
	"""https://github.com/reactive-firewall/{proj}"""
).format(proj=project)

extlinks = {
	"""issue""": (
		str("""{prefix}/{suffix}""").format(
			prefix=linkcode_url_prefix, suffix="""/issues/%s"""
		),
		"""issue #%s"""
	)
}

# try to link with official python3 documentation.
# see https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html for more
intersphinx_mapping = {
	"""python""": (
		"""https://docs.python.org/3""",
		(None, """python-inv.txt""")
	)
}


def linkcode_resolve(domain, info):
	if domain != "py" or not info["module"]:
		return None
	filename = info["module"].replace(".", "/")
	theResult = f"{linkcode_url_prefix}/blob/{DOCS_BUILD_REF}/{filename}.py"
	if "/pak.py" in theResult:
		theResult = theResult.replace("/pak.py", "/pak/__init__.py")
	if "/tests.py" in theResult:
		theResult = theResult.replace("/tests.py", "/tests/__init__.py")
	return theResult
