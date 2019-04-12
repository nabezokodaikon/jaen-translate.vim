# jaen-translate.vim
Translate Japanese/English

## Install
### dein.vim
```
[[plugins]]
repo = 'nabezokodaikon/jaen-translate.vim'
```

## Usage
1. Select the string to translate.
1. Running `JaEnTranslate` command.
1. The translated text is output.
  * Translated text is added to yank.

## Example
```
vnoremap <silent> <Leader>t :<C-u>JaEnTranslate<CR>
```

## Requirements
[Translate Shell](https://github.com/soimort/translate-shell)

## CREDITS
[Translate Shell](https://github.com/soimort/translate-shell)

## Author
[nabezokodaikon](https://github.com/nabezokodaikon)
