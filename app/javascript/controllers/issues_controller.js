import { Controller } from "@hotwired/stimulus";

import hljs from 'highlight.js/lib/core';

import javascript from 'highlight.js/lib/languages/javascript';
import ruby from 'highlight.js/lib/languages/ruby';
import bash from 'highlight.js/lib/languages/bash';
import erb from 'highlight.js/lib/languages/erb';
import json from 'highlight.js/lib/languages/json';
import scss from 'highlight.js/lib/languages/scss';
import shell from 'highlight.js/lib/languages/shell';
import xml from 'highlight.js/lib/languages/xml';
import yaml from 'highlight.js/lib/languages/yaml';

hljs.registerLanguage('javascript', javascript);
hljs.registerLanguage('ruby', ruby);
hljs.registerLanguage('bash', bash);
hljs.registerLanguage('erb', erb);
hljs.registerLanguage('json', json);
hljs.registerLanguage('scss', scss);
hljs.registerLanguage('shell', shell);
hljs.registerLanguage('xml', xml);
hljs.registerLanguage('yaml', yaml);

// ADDING KEYWORDS TO BASH/ZSH
const kwds = ['bin/dev', 'brew', 'bundle', 'cd', 'gem', 'git', 'gh', 'grep', 'heroku', 'importmap', 'irb', 'ls', 'mysql', 'node', 'php', 'postgresql', 'psql',
  'rails', 'rake', 'rm', 'service', 'sudo', 'touch', 'webpack',  'wget', 'yarn', 'zsh'];

const built_in = hljs.getLanguage('bash').keywords.built_in;
hljs.getLanguage('bash').keywords.built_in = [...new Set([...built_in ,...kwds])];

export default class extends Controller {
  static targets = ["tags", "tagsBtn", "form"]
  connect() {
    // console.log('hello world')
    // if (this.hasTagsTarget) {
    //   if (window.innerWidth <= 576) {
    //     this.tagsTarget.classList.remove('show')
    //     this.tagsBtnTarget.classList.add('collapsed')
    //   }
    // }

    

    // hljs.getLanguage('bash').keywords.heroku = ['built_in', 1]
    document.querySelectorAll('pre').forEach((el) => {
      hljs.highlightElement(el);
    });

    console.log(typeof(hljs.getLanguage('bash').keywords))
    console.log(hljs.getLanguage('bash').keywords)
  }

  showForm() {
    this.formTarget.classList.toggle('d-none');
  }
}
