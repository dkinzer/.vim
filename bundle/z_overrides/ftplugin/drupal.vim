" @file
" drupal  filetype specific overrides go here.
if &ft =~ '\<php\>' && exists('loaded_syntastic_plugin') && executable('phpcs')
  let g:syntastic_phpcs_conf = ' --standard=Drupal'
	\ . ' --extensions=php,module,inc,install,test,profile,theme'
endif
