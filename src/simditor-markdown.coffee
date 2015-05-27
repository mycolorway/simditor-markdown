
class SimditorMarkdown extends Simditor.Button

  name: 'markdown'

  icon: 'markdown'

  needFocus: false

  _init: ->
    super()

    @markdownEl = $ '<div class="markdown-editor" />'
      .insertBefore @editor.body
    @textarea = $ '<textarea/>'
      .appendTo @markdownEl

    @markdownChange = @editor.util.throttle =>
      @_autosizeTextarea()
      @_convert()
    , 300

    if @editor.util.support.oninput
      @textarea.on 'input', (e) =>
        @markdownChange()
    else
      @textarea.on 'keyup', (e) =>
        @markdownChange()

    # markedRenderer = new marked.Renderer()
    # markedRenderer.table = (header, body) =>
    #   console.log header
    #   console.log body
    # marked.setOptions
    #   renderer: markedRenderer

  status: ($node) ->
    true

  command: ->
    @editor.blur()
    @editor.el.toggleClass 'simditor-markdown'
    @editor.markdownMode = @editor.el.hasClass 'simditor-markdown'

    if @editor.markdownMode
      @editor.hidePopover()
      @_fileterUnsupportedTags()
      @textarea.val toMarkdown(@editor.getValue(), gfm: true)
      @_autosizeTextarea()
      @editor.body.removeAttr 'contenteditable'
    else
      @textarea.val ''
      @editor.body.attr 'contenteditable', 'true'

    for button in @editor.toolbar.buttons
      if button.name == 'markdown'
        button.setActive @editor.markdownMode
      else
        button.setDisabled @editor.markdownMode

    null

  _autosizeTextarea: ->
    @_textareaPadding ||= @textarea.innerHeight() - @textarea.height()
    @textarea.height(0)
      .height(@textarea[0].scrollHeight - @_textareaPadding)

  _convert: ->
    text = @textarea.val()
    @editor.setValue marked(text)

  _fileterUnsupportedTags: ->
    @editor.body.find('table colgroup').remove()


Simditor.Toolbar.addButton SimditorMarkdown
