{CompositeDisposable} = require 'atom'

module.exports = AtomHideTabs =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-hide-tabs:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    atomHideTabsViewState: @atomHideTabsView.serialize()

  toggle: ->
    atom.views.getView(atom.workspace).querySelector('.tab-bar').classList.toggle('hide-tabs');
