simditor-markdown
=============

Add a markdown editing button for Simditor. Use [marked](https://github.com/chjj/marked) as markdown parser and [to-markdown](https://github.com/domchristie/to-markdown) as HTML to markdown converter.

###Usage

Reference button and dependency script on your page with Simditor:

```html
<script type="text/javascript" src="[path]/marked.js"></script>
<script type="text/javascript" src="[path]/to-markdown.js"></script>
<script type="text/javascript" src="[path]/simditor-markdown.js"></script>

<link rel="stylesheet" href="[path]/simditor-markdown.css" media="screen" charset="utf-8" />
```

Add markdown button config when you initialize Simditor:

```js
var editor = new Simditor({
  textarea: $('#txt-editor'),
  toolbar: ['bold', 'italic', 'underline', 'color', '|', 'ol', 'ul', '|', 'markdown']
});
```

###Options

If you want to switch to markdown mode right after Simditor initialized, pass `markdown: true` to Simditor init options:

```js
var editor = new Simditor({
  textarea: $('#txt-editor'),
  markdown: true,
  toolbar: ['bold', 'italic', 'underline', 'color', '|', 'ol', 'ul', '|', 'markdown']
});
```
