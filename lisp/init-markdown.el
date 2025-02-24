(when (maybe-require-package 'markdown-mode)
  (add-auto-mode 'markdown-mode "\\.md\\.html\\'")
  (after-load 'whitespace-cleanup-mode
    (push 'markdown-mode whitespace-cleanup-mode-ignore-modes)))

(setq markdown-command "pandoc --ascii -f markdown -t html -s --mathjax --highlight-style espresso -c ~/.emacs.d/export-themes/markdown-css/style.css")

(provide 'init-markdown)
