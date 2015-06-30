$ ->

  # page object for the posts show page
  EASY_WIKI.posts.show = {

    # called when the posts show page loads
    # initializes page variables
    init: ->
      @bodyEditor = new Pen('#wiki-content').destroy()
      @save = $("#wiki-save")
      @edit = $("#wiki-edit")
      @content = $("#wiki-content")
      @content.on("dblclick", =>
        @performPageAction('edit')
      )
      @contentHistory = @content.html()
      @state = "view"

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
          @state = 'edit'
      save = =>
        if @state == 'edit'
          @bodyEditor.destroy()
          @save.hide()
          @edit.show()
          @state = 'view'
          if data?
            data.body = @content.html().trim()
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
          @state = 'view'
        else
          console.error("no. i can't perform action #{action} while in state #{state}")

      switch action
        when 'edit' then edit()
        when 'save' then save()
        when 'undo' then undo()
        else console.error("no. i don't know what #{action} is???")

  }
