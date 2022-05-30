"use strict";(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[427],{92539:function(e,t,a){a.r(t),a.d(t,{default:function(){return k}});a(33948),a(60285),a(41637);var l=a(67294),n=a(98069),o=a(331),i=a(62991),s=a(11321),c=a(37059);const r=function(e){let t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:24,a="";try{const l=new URL(e);a="https://www.google.com/s2/favicons?domain=".concat(l.hostname,"&sz=").concat(t)}catch(t){console.error("invalid URL: ".concat(e))}return a},m=e=>{let t=e;return/^(?:f|ht)tps?:\/\//.test(e)||(t="https://".concat(e)),t};function u(e){let{currentLinks:t,initialView:a,maxLinks:i,onDialogClose:c,initialTitle:u,initialSubtitle:d,onSave:k,formSpec:b}=e;const p=(0,l.useRef)(null),_=(0,l.createRef)(null),[f,E]=(0,l.useState)(a),[h,g]=(0,l.useState)(u),[v,N]=(0,l.useState)(d),[q,C]=(0,l.useState)(t),[y,w]=(0,l.useState)(null),[S,x]=(0,l.useState)(""),[L,T]=(0,l.useState)(""),[P,I]=(0,l.useState)(""),[R,j]=(0,l.useState)(!0),z=()=>{E("add"),g("Add bookmark"),N(""),x(""),I(""),j(!0)},D=()=>{const e=[...q];null!==y&&"edit"===f&&(e[y].title=P,e[y].url=m(S)),"add"!==f&&"add-only"!==f||S&&e.push({title:P,url:m(S)}),C(e),k(e),E("list")};(0,l.useEffect)((()=>{_&&_.current&&_.current.focus()}),[f]);const O=(0,l.useCallback)((e=>{const{value:t}=e.target;x(t),clearTimeout(p.current),j(!0),p.current=setTimeout((()=>{0===t.trim().length?(j(!0),T("URL link is required")):!1==(null!==t.match(/^(((H|h)(T|t)(T|t)(P|p)(S|s)?):\/\/)?[-a-zA-Z0-9@:%._+~#=]{2,100}\.[a-zA-Z]{2,10}(\/([-a-zA-Z0-9@:%_+.~#?&//=]*))?/))?(j(!0),T("The given URL link is invalid")):(j(!1),T(""))}),1e3)}),[]),Z=(0,l.useCallback)((e=>{I(e.currentTarget.value),S.length>0&&""!==L&&j(!1)}),[S]),A=(0,l.useCallback)((e=>{13===e.keyCode&&""===L&&D()}),[L,P,S]);const U=(0,o.Z)();return l.createElement(n.N3,null,l.createElement(s.Z,{titleId:U,className:"quicklinks-modal",onClose:c},l.createElement("header",{className:"quicklinks-modal__header"},l.createElement("h1",{id:U,className:"quicklinks-modal__title"},h),v&&l.createElement("h2",{className:"quicklinks-modal__subtitle"},v),l.createElement("button",{type:"button",onClick:c,className:"quicklinks-modal__header-close"},l.createElement("svg",{className:"svg-icon"},l.createElement("title",null,"Close modal"),l.createElement("use",{href:"#close"})))),l.createElement("div",{className:"quicklinks-modal__body"},"list"===f&&l.createElement(l.Fragment,null,q&&q.map(((e,t)=>l.createElement("div",{className:"quicklinks-modal__container",key:t},l.createElement("button",{type:"button","aria-label":"Edit bookmark ".concat(e.title),className:"quicklinks-modal__edit-button",onClick:a=>((e,t,a)=>{x(t.url),I(t.title),E("edit"),g("Update Bookmark"),N(""),j(!1),w(a)})(0,e,t)},l.createElement("div",{className:"bookmark-icon"},l.createElement("img",{alt:"link icon",className:"bookmark-icon-image",height:24,src:r(e.url),loading:"lazy",width:24})),l.createElement("div",{className:"quicklinks-modal__edit-button-title"},e.title),l.createElement("svg",{className:"svg-icon"},l.createElement("use",{href:"#edit"}))),l.createElement("button",{type:"button","aria-label":"Delete bookmark ".concat(e.title),className:"quicklinks-modal__delete-button",onClick:e=>((e,t)=>{const a=[...q];a.splice(t,1),C(a),j(!1),k&&k(a),a.length<=0&&z()})(0,t)},l.createElement("svg",{className:"svg-icon"},l.createElement("use",{href:"#subtract-alt"}))))))),("add"===f||"add-only"===f||"edit"===f)&&l.createElement("div",{className:"form custom-form custom-form--color-grey70"},l.createElement("div",{className:"sq-form-question sq-form-question-text",id:"sq_form_field_wrapper_bookmark-url"},l.createElement("label",{className:"sq-form-question-title",htmlFor:"bookmark-url-input"},"URL link",l.createElement("abbr",{className:"sq-form-required-field",title:"required"},"*")),l.createElement("div",{className:"sq-form-question-answer"},l.createElement("input",{ref:_,autoComplete:"off",autoCapitalize:"off",type:"text",name:"bookmark-url",size:"30",maxLength:"300",placeholder:b.linkUrlPlaceholder,id:"bookmark-url-input",className:"sq-form-field",value:S,onChange:O,onKeyDown:A})),l.createElement("span",{className:"sq-form-error"},L)),l.createElement("div",{className:"sq-form-question sq-form-question-text",id:"sq_form_field_wrapper_bookmark-title"},l.createElement("label",{className:"sq-form-question-title",htmlFor:"bookmark-tile-input"},"Name of bookmark"),l.createElement("div",{className:"sq-form-question-answer"},l.createElement("input",{autoComplete:"off",type:"text",name:"bookmark-title",size:"30",maxLength:"300",placeholder:b.linkTitlePlaceholder,id:"bookmark-tile-input",className:"sq-form-field",value:P,onChange:Z,onKeyDown:A})),l.createElement("em",{className:"sq-form-question-note"},"Try to keep it as short as possible.")))),(B=R,l.createElement("footer",{className:["quicklinks-modal__footer","list"!==f&&"quicklinks-modal__footer-right-aligned"].join(" ")},"list"===f?l.createElement(l.Fragment,null,q&&q.length===i?l.createElement("p",{className:"quicklinks__dialog-limit-message"},"You have reached your bookmark limit."):l.createElement("div",{className:"quicklinks-modal__footer-buttons-container"},l.createElement("button",{"aria-label":"Add new bookmark",type:"button",className:"quicklinks-modal__footer-button quicklinks-modal__footer-button--dashed",onClick:e=>z()},l.createElement("svg",{className:"svg-icon"},l.createElement("use",{href:"#add"}))))):l.createElement("div",{className:"quicklinks-modal__footer-buttons-container"},q&&q.length>0&&l.createElement("button",{type:"button",className:"quicklinks-modal__footer-button","aria-label":"Go back",onClick:e=>(E("list"),g(u),void N(d))},"Go Back"),l.createElement("button",{type:"button","aria-label":"Save new bookmark",disabled:B,className:"quicklinks-modal__footer-button quicklinks-modal__footer-button--save",onClick:e=>D()},"Save"))))));var B}function d(e){let{links:t,maxLinks:a,dialogView:n,addBookmarks:o,onDialogClose:i,onSave:s,formSpec:c,listSpec:m}=e;return l.createElement("div",{className:"quicklinks__list"},t&&t.map(((e,t)=>l.createElement("div",{className:"quicklinks__link",key:t},l.createElement("button",{type:"button","aria-label":"Open bookmark ".concat(e.title),className:"quicklinks__button",onClick:t=>{return a=e.url,void("_blank"===m.openLinkTarget?window.open(a,"_blank"):window.location.href=a);var a}},l.createElement("div",{className:"quicklinks__link-icon"},l.createElement("img",{alt:"link icon",className:"quicklinks__link-icon-image",height:24,src:r(e.url),loading:"lazy",width:24})),l.createElement("div",{className:"quicklinks__link-title"},e.title))))),(!a||t.length<a)&&l.createElement("div",{className:"quicklinks__link"},l.createElement("button",{type:"button","aria-label":"Add new bookmark",className:"quicklinks__button quicklinks__button--dashed",onClick:o},l.createElement("svg",{className:"svg-icon"},l.createElement("use",{href:"#add"})))),"list"===n&&l.createElement(u,{currentLinks:t,maxLinks:a,onDialogClose:i,initialView:n,initialTitle:"Bookmarks",initialSubtitle:"Add up to four bookmarks.",onSave:s,formSpec:c}),"add-only"===n&&l.createElement(u,{currentLinks:t,maxLinks:a,onDialogClose:i,initialView:n,initialTitle:"New bookmark",onSave:s,formSpec:c}))}function k(e){let{title:t,maxLinks:a,formSpec:n,listSpec:o}=e;const[s,r]=(0,l.useState)(!1),[m,u]=(0,l.useState)("list"),{bookmarks:k,getBookmarks:b,updateBookmarks:p}=(0,l.useContext)(i.Z);(0,l.useEffect)((()=>{(async()=>{await b(),k.length<=0?u("add-only"):u("list")})()}),[]);const _=(0,l.useCallback)((()=>{k.length<=0?u("add-only"):u("list"),r(!0)}),[k]),f=(0,l.useCallback)((()=>{u("add-only"),r(!0)}),[]),E=(0,l.useCallback)((()=>{r(!1)}),[]),h=(0,l.useCallback)((e=>{(async()=>{await p(e)})()}),[]);return l.createElement(c.Z,{headingIcon:l.createElement("button",{type:"button","aria-label":"Edit bookmarks",onClick:_,className:"heading-icon"},l.createElement("svg",{className:"svg-icon"},l.createElement("use",{href:"#edit"}))),title:t,wrapperClasses:"quicklinks",contentClasses:"quicklinks__container"},l.createElement(d,{dialogView:!0===s?m:void 0,links:k,maxLinks:a,onDialogClose:E,onSave:h,formSpec:n,listSpec:o,addBookmarks:f}))}k.defaultProps={maxLinks:4,title:"",documentId:666,listSpec:{openLinkTarget:"_blank"},formSpec:{linkUrlPlaceholder:"Enter your link url",linkTitlePlaceholder:"Enter your link title"}}},37059:function(e,t,a){a.d(t,{Z:function(){return i}});a(33948);var l=a(67294);function n(){return n=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var a=arguments[t];for(var l in a)Object.prototype.hasOwnProperty.call(a,l)&&(e[l]=a[l])}return e},n.apply(this,arguments)}function o(e){let{children:t,toggleIsCollapsed:a,isCollapsed:n,iscollapsible:o,id:i}=e;return o?l.createElement("button",{className:"collapsible-card__header",type:"button",onClick:a,"aria-expanded":!n,"aria-controls":"content-".concat(i)},t):l.createElement("div",{className:"collapsible-card__header"},t)}function i(e){const{wrapperClasses:t,contentClasses:a,children:i,id:s,headingIcon:c,iscollapsible:r,isInitialCollapsed:m,isScrollable:u,subTitle:d,title:k,...b}=e;let p="";s&&(p="ComponentCard-".concat(s));let _=m||!1;p&&(_="collapsed"===localStorage.getItem(p));const[f,E]=(0,l.useState)(_),h=["collapsible-card","no-wysiwyg",t].join(" "),g=["collapsible-card__contents",a,u&&"collapsible-card--scrollable"].join(" "),v=["svg-icon",!1===f&&"collapsible-card__collapsed"].join(" "),N=(0,l.useCallback)((()=>{E(!f),p&&localStorage.setItem(p,f?"":"collapsed")}),[p,f]);return l.createElement("div",n({className:h,id:s},b),l.createElement(o,{iscollapsible:r,toggleIsCollapsed:N,isCollapsed:f,id:s},l.createElement("h2",{className:"collapsible-card__header-text"},k),(d||r||c)&&l.createElement("div",{className:"collapsible-card__header-right"},d&&l.createElement("h3",{className:"collapsible-card__header-text collapsible-card__header-text--sub-title"},d),r&&l.createElement("svg",{className:"".concat(v," collapsible-card__more-menu-icon")},l.createElement("title",null,f?"Expand panel":"Collapse panel"),l.createElement("use",{href:"#chevron"})),c)),(!0!==r||!0===r&&!1===f)&&l.createElement("div",{className:g,id:"content-".concat(s),role:"region",tabIndex:-1},i))}},11321:function(e,t,a){a.d(t,{Z:function(){return c}});var l=a(67294),n=a(98069),o=a(34708),i=a(49641);function s(){return s=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var a=arguments[t];for(var l in a)Object.prototype.hasOwnProperty.call(a,l)&&(e[l]=a[l])}return e},s.apply(this,arguments)}function c(e){let{titleId:t,title:a,onClose:o,children:s,className:c}=e;return l.createElement(n.Xj,null,l.createElement("div",{className:"no-wysiwyg modal-wrapper ".concat(c?"".concat(c,"-wrapper"):"")},l.createElement(i.MT,{contain:!0,restoreFocus:!0,autoFocus:!0},l.createElement(r,{titleId:t,title:a,onClose:o,className:c},s))))}function r(e){let{titleId:t,title:a,onClose:c,children:r,className:m}=e;const u={"aria-describedby":t,title:a,onClose:c,isDismissable:!0,isOpen:!0},d=l.useRef(),k=l.useRef(),b=(0,i.bO)(),{overlayProps:p,underlayProps:_}=(0,n.Ir)(u,k);(0,n.tk)();const{modalProps:f}=(0,n.dd)(),{dialogProps:E,titleProps:h}=(0,o.R)(u,k);return(0,l.useEffect)((()=>{d.current.removeAttribute("hidden"),b.focusFirst()}),[d]),l.createElement("div",s({ref:d},_,{hidden:!0,className:"modal ".concat(m||"")}),l.createElement("div",s({ref:k},p,E,f,{"aria-modal":"true",tabIndex:"-1",className:"modal__content ".concat(m?"".concat(m,"__content"):"")}),t?"":l.createElement("h2",s({},h,{className:"".concat(m?"".concat(m,"__title"):"")}),a),r))}}}]);
//# sourceMappingURL=Bookmarks-415fb2200486b01dcf96.js.map