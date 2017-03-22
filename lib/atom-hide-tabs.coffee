{CompositeDisposable} = require 'atom'

module.exports = AtomHideTabs =
  subscriptions: null

  activate: (state) ->
    # Set default state to false
    @hidden = false
    # Array of all panes
    @panes = []

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-hide-tabs:toggle': => @toggle()

    # Register callback which handles new pane
    @subscriptions.add atom.workspace.observePanes (pane) => @handlePane pane

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    # Toggle internal state
    @hidden = not @hidden

    # Remove closed panes
    @panes = @panes.filter (pane) -> pane.alive isnt false

    # Toggle class for all active panes
    for pane in @panes
      atom.views.getView(pane).querySelector('.tab-bar').classList.toggle('hide-tabs')

  handlePane: (pane) ->
    @panes.push pane

    # Set hide-tabs css class if tabs are hidden
    if @hidden
      atom.views.getView(pane).querySelector('.tab-bar').classList.add('hide-tabs')
