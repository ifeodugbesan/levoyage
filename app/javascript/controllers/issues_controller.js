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
    document.querySelectorAll('pre').forEach((el) => {
      hljs.highlightElement(el);
    });
  }

  showForm() {
    this.formTarget.classList.toggle('d-none');
  }
}
