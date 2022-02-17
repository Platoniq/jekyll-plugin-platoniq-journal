Jekyll Plugin Platoniq Journal
==============================

A collection of plugins for Jekyll:

- call to action block tag
- numbers tag
- links tag
- quote tag

## Installation

Add this line to your application's Gemfile:

    gem 'jekyll-plugin-platoniq-journal'

And then execute:

    $ bundle

## Usage

Tags can be used in a `.md` file

### call to action block tag

```
{% cta {"url":"https://platoniq.net", "label": "call to action button"} %}
# This is my CTA

- one item
- two item
{% endcta %}
```

### numbers tag

```
{% numbers {"first label":"0.123", "second label":"50%", "third label": "123"} %}
```

### links tag

```
{% links {
    "title": "Our references", "items": [
            { "url": "https://platoniq.net", "title": "Link to the galaxy and beyond"},
            { "url": "https://platoniq.net", "title": "Visit Planet Toniq"}
        ]
    }
%}
```

### quote block tag

Basic quote block:

```liquid
{% quote %}
To quote or not to quote: That is the question.
{% endquote %}
```

Quote block with params:

```liquid
{% quote { "author": "Wwwilliam Shakespeare", 
           "icon": "svg/icon-quote_alt.liquid" } %}

To quote or not to quote: That is the question.
{% endquote %}
```

## License

The theme is available as open source under the terms of the [GNU AFFERO GENERAL PUBLIC LICENSE](https://opensource.org/licenses/AGPL-3.0).

## Credits

This theme has been developed by ![Platoniq](https://avatars.githubusercontent.com/u/31537393?s=200&v=4)
