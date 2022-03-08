# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
# pin 'popper', to: 'popper.js'
# pin 'bootstrap', to: 'bootstrap.min.js'
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js', preload: true
pin 'jquery-touch-events', to: 'https://ga.jspm.io/npm:jquery-touch-events@1.0.7/index.js', preload: true
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.2-2/lib/assets/compiled/rails-ujs.js', preload: true
