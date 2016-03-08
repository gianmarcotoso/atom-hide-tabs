# atom-hide-tabs package

Hides Atom's tab bar without disabling the tab plugin.

## Why?

Because I like to have a shorcut to close all open files and I found that the only way to do so, currently, is to close all tabs. The problem is that I also don't like tabs (I know, I'm picky), and the shortcut doesn't work if the `tabs` package is disabled. The solution? Hide them. It might be a dirty hack, but I'm ok with it.

## How?

After installing the package just run the `atom-hide-tabs:toggle` command from the command palette or through the defined shortcut (default is `ctrl-alt-t`). If you want to run this automatically, you can add the following line to your init script:

```javascript
atom.commands.dispatch(atom.views.getView(atom.workspace), 'atom-hide-tabs:toggle');
```
