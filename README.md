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
{% call_to_action {"url":"https://platoniq.net", "label": "call to action button"} %}
# This is my CTA

- one item
- two item
{% endcall_to_action %}
```

### numbers tag

```
{% numbers { "items": [ { "label": "first label", "number": "0.123"}, { "label": "second label", "number": "50%" }, { "label": "third label", "number":  "123" } ] } %}
```

### links tag

```
{% links { "title": "Our references", "items": [ { "url": "https://platoniq.net", "title": "Link to the galaxy and beyond"}, { "url": "https://platoniq.net", "title": "Visit Planet Toniq"} ] } %}
```

### documents tag

```
{% documents { "title": "Our references", "items": [ { "file": "https://platoniq.net", "title": "Link to the galaxy and beyond"}, { "file": "https://platoniq.net", "title": "Visit Planet Toniq"} ] } %}
```

### file tag

```
{% file { "title": "A very cool file", "info": "4kB PDF", "file": "https://cool-pdf.org/file1.pdf", "image": "/media/whatever.png", "button_text": "Download", "button_icon": "icon-download" } %}
```


### gallery tag

```
{% gallery { "images": [ { "path": "/media/whatever1.png", "alt": "Picture of the galaxy when it was born", "credits": "Ptolemy" }, { "path": "/media/whatever2.png", "alt": "Pie chart of my dreams", "credits": "Anonymous" } ] %}
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

### stickers tag

```
{% stickers { "layout": "layout-one", "sticker_one": "/media/stickers/wilder-journal-x/thumbs_up.png", "sticker_one_animation": "animation-glitch", "sticker_two": "/media/stickers/wilder-journal-x/heart.png", "sticker_two_animation": "animation-none" } %}
```

## License

The theme is available as open source under the terms of the [GNU AFFERO GENERAL PUBLIC LICENSE](https://opensource.org/licenses/AGPL-3.0).

## Credits

This theme has been developed by ![Platoniq](https://avatars.githubusercontent.com/u/31537393?s=200&v=4)
