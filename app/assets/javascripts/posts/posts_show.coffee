$ ->

  # page object for the posts show page
  EASY_WIKI.posts.show = {

    # called when the posts show page loads
    # initializes page variables
    init: ->
      @bodyEditor = new Pen({editor: document.getElementById('wiki-content'), stay: false}).destroy()
      @save = $("#wiki-save")
      @edit = $("#wiki-edit")
      @tagInput = $('#wiki-tags-input')
      @content = $("#wiki-content")
      @titleInput = $('#wiki-title-input')
      @content.on("dblclick", =>
        @performPageAction('edit')
      )
      $('#wiki-title').on("dblclick", =>
        @performPageAction('edit')
      )
      @contentHistory = @content.html()
      @state = "view"
      @tagInput.prop("disabled", true)
      @tags = @tagInput.val()
      @title = @titleInput.val()

    # change the state of the page by performing the specified page action
    # valid actions on this page are: 'edit', 'undo', 'save'
    #
    # edit: if we aren't currently editing, edit the wiki content
    # undo: if we're currently editing, undo all recent changes and stop editing
    # save: if we're currently editing, save current changes and stop editing
    performPageAction: (action, data) ->
      edit = =>
        unless @state == 'edit'
          @contentHistory = @content.html()
          @bodyEditor.rebuild()
          @save.show()
          @edit.hide()
          #@tagInput.prop("disabled", false)
          @titleInput.prop("disabled", false).css("background-color","rgb(250,250,250)")
          @content.css("background-color","rgb(250,250,250)")
          @state = 'edit'
      save = =>
        if @state == 'edit'
          @bodyEditor.destroy()
          @save.hide()
          @edit.show()
          @state = 'view'
          #@tagInput.prop("disabled", true)
          @titleInput.prop("disabled", true).css("background-color","")
          @tags = @tagInput.val()
          @title = @titleInput.val()
          @content.css("background-color","")
          if data?
            data.body = @content.html().trim()
            data.tag_list = @tags
            data.title = @title.trim()
            $.ajax({
              type:'PATCH',
              url: "/posts/#{data.id}",
              data: {post: data}
            });
        else
          console.error("no. i can't perform action #{action} while in state #{state}")
      undo = =>
        if @state == 'edit'
          @bodyEditor.destroy()
          @save.hide()
          @edit.show()
          @content.html(@contentHistory)
          #@tagInput.prop("disabled", true).val(@tags)
          @titleInput.prop("disabled", true).val(@title).css("background-color","")
          @state = 'view'
          @content.css("background-color","")
        else
          console.error("no. i can't perform action #{action} while in state #{state}")

      switch action
        when 'edit' then edit()
        when 'save' then save()
        when 'undo' then undo()
        else console.error("no. i don't know what #{action} is???")

  }
