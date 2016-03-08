AtomHideTabs = require '../lib/atom-hide-tabs'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomHideTabs", ->
  [workspaceElement, activationPromise, tabBarPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    tabBarPromise = atom.packages.activatePackage('tabs')
    activationPromise = atom.packages.activatePackage('atom-hide-tabs')

  describe "when the atom-hide-tabs:toggle event is triggered", ->
    it "adds or removes the .hide-tabs class to the tab bar", ->
      # Before the activation event everything should be as vanilla as possible
      expect(workspaceElement.querySelector('.hide-tabs')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-hide-tabs:toggle'

      waitsForPromise ->
        activationPromise

      waitsForPromise ->
        tabBarPromise

      runs ->
        expect(workspaceElement.querySelector('.hide-tabs')).toExist()

        tabBar = workspaceElement.querySelector('.tab-bar');
        expect(tabBar.classList.contains 'hide-tabs').toBe true
        atom.commands.dispatch workspaceElement, 'atom-hide-tabs:toggle'
        expect(tabBar.classList.contains 'hide-tabs').toBe false
