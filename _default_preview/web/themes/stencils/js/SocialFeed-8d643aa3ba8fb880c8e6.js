/*! For license information please see SocialFeed-8d643aa3ba8fb880c8e6.js.LICENSE.txt */
"use strict";(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[851],{64663:function(e,a,t){t.d(a,{U:function(){return o}});var r=t(27354),n=t(49641),c=t(3366);function o(e,a){let t,{elementType:o="button",isDisabled:l,onPress:s,onPressStart:i,onPressEnd:d,onPressChange:m,preventFocusOnPress:u,onClick:p,href:f,target:g,rel:_,type:v="button"}=e;t="button"===o?{type:v,disabled:l}:{role:"button",tabIndex:l?void 0:0,href:"a"===o&&l?void 0:f,target:"a"===o?g:void 0,type:"input"===o?v:void 0,disabled:"input"===o?l:void 0,"aria-disabled":l&&"input"!==o?l:void 0,rel:"a"===o?_:void 0};let{pressProps:h,isPressed:b}=(0,r.r7)({onPressStart:i,onPressEnd:d,onPressChange:m,onPress:s,isDisabled:l,preventFocusOnPress:u,ref:a}),{focusableProps:E}=(0,n.kc)(e,a),y=(0,c.dG)(E,h);return y=(0,c.dG)(y,(0,c.zL)(e,{labelable:!0})),{isPressed:b,buttonProps:(0,c.dG)(t,y,{"aria-haspopup":e["aria-haspopup"],"aria-expanded":e["aria-expanded"],"aria-controls":e["aria-controls"],"aria-pressed":e["aria-pressed"],onClick:e=>{p&&(p(e),console.warn("onClick is deprecated, please use onPress"))}})}}},65525:function(e,a,t){t.d(a,{D:function(){return r}});t(33948),t(17727);class r{constructor(){this.requests=new Map}debounce(e,a){const t=JSON.stringify(e);if(!this.requests.has(t)){const e=a();e.finally((()=>{this.requests.delete(t)})),this.requests.set(t,e)}return this.requests.get(t)}get(e){return this.requests.get(JSON.stringify(e))}}},331:function(e,a,t){t.d(a,{Z:function(){return r}});t(15306),t(82472),t(3462),t(33824);function r(){return([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,(e=>(e^crypto.getRandomValues(new Uint8Array(1))[0]&15>>e/4).toString(16)))}},11321:function(e,a,t){t.d(a,{Z:function(){return s}});var r=t(67294),n=t(12988),c=t(34708),o=t(49641);function l(){return l=Object.assign||function(e){for(var a=1;a<arguments.length;a++){var t=arguments[a];for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r])}return e},l.apply(this,arguments)}function s(e){let{titleId:a,title:t,onClose:c,children:l,className:s}=e;return r.createElement(n.Xj,null,r.createElement("div",{className:"no-wysiwyg modal-wrapper ".concat(s?"".concat(s,"-wrapper"):"")},r.createElement(o.MT,{contain:!0,restoreFocus:!0,autoFocus:!0},r.createElement(i,{titleId:a,title:t,onClose:c,className:s},l))))}function i(e){let{titleId:a,title:t,onClose:s,children:i,className:d}=e;const m={"aria-describedby":a,title:t,onClose:s,isDismissable:!0,isOpen:!0},u=r.useRef(),p=r.useRef(),f=(0,o.bO)(),{overlayProps:g,underlayProps:_}=(0,n.Ir)(m,p);(0,n.tk)();const{modalProps:v}=(0,n.dd)(),{dialogProps:h,titleProps:b}=(0,c.R)(m,p);return(0,r.useEffect)((()=>{u.current.removeAttribute("hidden"),f.focusFirst()}),[u]),r.createElement("div",l({ref:u},_,{hidden:!0,className:"modal ".concat(d||"")}),r.createElement("div",l({ref:p},g,h,v,{"aria-modal":"true",tabIndex:"-1",className:"modal__content ".concat(d?"".concat(d,"__content"):"")}),a?"":r.createElement("h2",l({},b,{className:"".concat(d?"".concat(d,"__title"):"")}),t),i))}},6175:function(e,a,t){t.d(a,{Z:function(){return c}});t(33948);var r=t(67294),n=t(64663);function c(){const[e,a]=(0,r.useState)(!1),t=(0,r.useRef)();let{buttonProps:c}=(0,n.U)({onPress:()=>a(!0)},t);return c={...c,role:"button",tabIndex:"0","aria-label":"Open in modal"},delete c.type,{openModalRef:t,modalOpenProps:c,isModalOpen:e,setIsModalOpen:a}}},63794:function(e,a,t){t.r(a),t.d(a,{default:function(){return F}});var r=t(67294),n=t(12988),c=new WeakMap,o=new WeakMap,l={},s=0,i=function(e,a,t){void 0===a&&(a=function(e){return"undefined"==typeof document?null:(Array.isArray(e)?e[0]:e).ownerDocument.body}(e)),void 0===t&&(t="data-aria-hidden");var r=Array.isArray(e)?e:[e];l[t]||(l[t]=new WeakMap);var n=l[t],i=[],d=new Set,m=function(e){e&&!d.has(e)&&(d.add(e),m(e.parentNode))};r.forEach(m);var u=function(e){!e||r.indexOf(e)>=0||Array.prototype.forEach.call(e.children,(function(e){if(d.has(e))u(e);else{var a=e.getAttribute("aria-hidden"),r=null!==a&&"false"!==a,l=(c.get(e)||0)+1,s=(n.get(e)||0)+1;c.set(e,l),n.set(e,s),i.push(e),1===l&&r&&o.set(e,!0),1===s&&e.setAttribute(t,"true"),r||e.setAttribute("aria-hidden","true")}}))};return u(a),d.clear(),s++,function(){i.forEach((function(e){var a=c.get(e)-1,r=n.get(e)-1;c.set(e,a),n.set(e,r),a||(o.has(e)||e.removeAttribute("aria-hidden"),o.delete(e)),r||e.removeAttribute(t)})),--s||(c=new WeakMap,c=new WeakMap,o=new WeakMap,l={})}};const d="undefined"!=typeof document?document:void 0;var m=t(25857);t(33948);const u=(0,r.createContext)({isLoading:!1,feedData:[],getFeedData:null}),p=e=>{let{children:a,socialFeedService:t}=e;const[n,c]=(0,r.useState)(!1),[o,l]=(0,r.useState)([]),s=(0,r.useCallback)((e=>(c(!0),t.getFeedData(e).then((e=>{l(e),c(!1)})))),[]);return r.createElement(u.Provider,{value:{isLoading:n,feedData:o,getFeedData:s}},a)};var f=t(65525);class g{constructor(e){if(!e)throw new Error("dto is required when instantiating a new SocialFeedService");["socialFeedAdapter"].forEach((a=>{if(!e[a])throw new Error("".concat(a," property is required when instantiating a new SocialFeedService"))})),this.promiseDebouncer=new f.D,this.socialFeedAdapter=e.socialFeedAdapter}getFeedData(e){return this.promiseDebouncer.debounce({method:"getFeedData",...e},(()=>this.socialFeedAdapter.getFeedData(e)))}}var _=t(19013),v=t(4810),h=t(13882);function b(e,a){(0,h.Z)(1,arguments);var t=(0,_.Z)(e);if(isNaN(t.getTime()))throw new RangeError("Invalid time value");var r=null!=a&&a.format?String(a.format):"extended",n=null!=a&&a.representation?String(a.representation):"complete";if("extended"!==r&&"basic"!==r)throw new RangeError("format must be 'extended' or 'basic'");if("date"!==n&&"time"!==n&&"complete"!==n)throw new RangeError("representation must be 'date', 'time', or 'complete'");var c="",o="",l="extended"===r?"-":"",s="extended"===r?":":"";if("time"!==n){var i=(0,v.Z)(t.getDate(),2),d=(0,v.Z)(t.getMonth()+1,2),m=(0,v.Z)(t.getFullYear(),4);c="".concat(m).concat(l).concat(d).concat(l).concat(i)}if("date"!==n){var u=t.getTimezoneOffset();if(0!==u){var p=Math.abs(u),f=(0,v.Z)(Math.floor(p/60),2),g=(0,v.Z)(p%60,2),b=u<0?"+":"-";o="".concat(b).concat(f,":").concat(g)}else o="Z";var E=(0,v.Z)(t.getHours(),2),y=(0,v.Z)(t.getMinutes(),2),N=(0,v.Z)(t.getSeconds(),2),w=""===c?"":"T",P=[E,y,N].join(s);c="".concat(c).concat(w).concat(P).concat(o)}return c}var E=t(13122),y=t(331),N=t(11321),w=t(6175);function P(){return P=Object.assign||function(e){for(var a=1;a<arguments.length;a++){var t=arguments[a];for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r])}return e},P.apply(this,arguments)}function O(e){const{accountName:a,accountImage:t,createdDate:n,source:c,text:o,url:l,image:s,lazyLoadImages:i}=e,[d,m]=(0,r.useState)(!1),{openModalRef:u,modalOpenProps:p,isModalOpen:f,setIsModalOpen:g}=(0,w.Z)();let _,v=!1,h=o;switch(h.length>100&&!d&&(v=!0,h=h.slice(0,100)),c){case"twitter":_="logo-twitter";break;case"facebook":_="logo-facebook";break;default:_="external"}return r.createElement("article",{className:"social-card"},r.createElement("div",P({},p,{ref:u,className:"social-card__open-modal"}),r.createElement("header",{className:"social-card__header"},r.createElement("div",{className:"social-card__header-image"},r.createElement("img",{alt:"",src:t,loading:"".concat(i?"lazy":""),className:"social-card__account-image"})),r.createElement("div",{className:"social-card__title"},r.createElement("time",{dateTime:b(n,{representation:"date"}),className:"social-card__post-created"},(0,E.Z)(n,new Date,{addSuffix:!0})),r.createElement("div",{className:"social-card__account-name"},a)),r.createElement("a",{href:l,target:"_blank","aria-label":"View at ".concat(c," (Opens in new window)"),rel:"noopener noreferrer",onClick:e=>e.stopPropagation(),className:"social-card__view-external social-card__view-external--".concat(_)},r.createElement("svg",{className:"svg-icon"},r.createElement("use",{href:"#".concat(_)})))),r.createElement("div",{className:"social-card__body"},h,v&&r.createElement(r.Fragment,null,r.createElement("span",null,"..."),r.createElement("button",{type:"button",className:"social-card__show-more",onClick:e=>{e.stopPropagation(),m(!0)}},"show more")),s&&r.createElement("img",{alt:"",src:s,loading:"".concat(i?"lazy":""),className:"social-card__body-image"}))),f&&r.createElement(k,P({},e,{handleModalClose:()=>{g(!1)}})))}function k(e){let a,{accountName:t,accountImage:n,createdDate:c,source:o,text:l,url:s,image:i,video:d,videoCaptions:m,handleModalClose:u}=e;d?a=r.createElement("div",{className:"social-card-modal__video-embed-wrapper"},r.createElement("video",{src:d,className:"social-card-modal__video-embed"},m&&r.createElement("track",{kind:"captions",src:m}))):i&&(a=r.createElement("img",{alt:"",loading:"lazy",src:i,className:"social-card-modal__body-image"}));const p=(0,y.Z)();return r.createElement(N.Z,{titleId:p,onClose:u,className:"social-card-modal"},r.createElement("header",{className:"social-card-modal__header"},r.createElement("div",{className:"social-card-modal__header-image"},r.createElement("img",{alt:"",src:n,loading:"lazy",className:"social-card-modal__account-image"})),r.createElement("div",{id:p,className:"social-card-modal__title"},r.createElement("time",{dateTime:b(c,{representation:"date"}),className:"social-card__post-created"},(0,E.Z)(c,new Date,{addSuffix:!0})),r.createElement("div",{className:"social-card-modal__account-name"},t)),r.createElement("button",{type:"button",onClick:u,"aria-label":"close modal",className:"social-card-modal__close-icon"},r.createElement("svg",{className:"svg-icon"},r.createElement("use",{href:"#close"})))),r.createElement("div",{className:"social-card-modal__body"},l,a),r.createElement("footer",{className:"social-card-modal__footer"},r.createElement("a",{href:s,target:"_blank",className:"social-card-modal__open-external-button",rel:"noreferrer"},"View on ",o)))}var C=t(27354);function S(){return S=Object.assign||function(e){for(var a=1;a<arguments.length;a++){var t=arguments[a];for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r])}return e},S.apply(this,arguments)}function x(e){const{accountName:a,accountImage:t,createdDate:n,source:c,text:o,url:l,image:s,lazyLoadImages:i}=e,[d,m]=(0,r.useState)(!1),{openModalRef:u,modalOpenProps:p,isModalOpen:f,setIsModalOpen:g}=function(){const[e,a]=(0,r.useState)(!1),t=(0,r.useRef)(),{keyboardProps:n}=(0,C.v5)({onKeyUp:e=>{e.target===t.current&&(13===e.keyCode&&a(!0),32===e.keyCode&&a(!0))}});return n.onClick=()=>a(!0),{openModalRef:t,modalOpenProps:n,isModalOpen:e,setIsModalOpen:a}}();let _=!1,v=o;v.length>100&&!d&&(_=!0,v=v.slice(0,100));const h="external";return r.createElement("article",{className:"social-card"},r.createElement("div",S({},p,{role:"button",tabIndex:"0","aria-label":"Open in modal",ref:u,className:"social-card__open-modal"}),r.createElement("header",{className:"social-card__header"},r.createElement("div",{className:"social-card__header-image"},r.createElement("img",{alt:"",src:t,loading:"".concat(i?"lazy":""),className:"social-card__account-image"})),r.createElement("div",{className:"social-card__title"},r.createElement("time",{dateTime:b(n,{representation:"date"}),className:"social-card__post-created"},(0,E.Z)(n,new Date,{addSuffix:!0})),r.createElement("div",{className:"social-card__account-name"},a)),r.createElement("a",{href:l,target:"_blank","aria-label":"View at ".concat(c," (Opens in new window)"),rel:"noopener noreferrer",onClick:e=>e.stopPropagation(),className:"social-card__view-external social-card__view-external--".concat(h)},r.createElement("svg",{className:"svg-icon"},r.createElement("use",{href:"#".concat(h)})))),r.createElement("div",{className:"social-card__body"},v,_&&r.createElement(r.Fragment,null,r.createElement("span",null,"..."),r.createElement("button",{type:"button",className:"social-card__show-more",onClick:e=>{e.stopPropagation(),m(!0)}},"show more")),s&&r.createElement("img",{alt:"",src:s,loading:"".concat(i?"lazy":""),className:"social-card__body-image"}))),f&&r.createElement(M,S({},e,{handleEventModalClose:()=>{g(!1)}})))}function M(e){let{accountName:a,accountImage:t,createdDate:n,source:c,text:o,url:l,video:s,handleEventModalClose:i}=e;const d=(0,y.Z)();return r.createElement(N.Z,{titleId:d,onClose:i,className:"social-card-modal"},r.createElement("header",{className:"social-card-modal__header"},r.createElement("div",{className:"social-card-modal__header-image"},r.createElement("img",{alt:"",src:t,loading:"lazy",className:"social-card-modal__account-image"})),r.createElement("div",{id:d,className:"social-card-modal__title"},r.createElement("time",{dateTime:b(n,{representation:"date"}),className:"social-card__post-created"},(0,E.Z)(n,new Date,{addSuffix:!0})),r.createElement("div",{className:"social-card-modal__account-name"},a)),r.createElement("button",{type:"button",onClick:i,"aria-label":"close modal",className:"social-card-modal__close-icon"},r.createElement("svg",{className:"svg-icon"},r.createElement("use",{href:"#close"})))),r.createElement("div",{className:"social-card-modal__body"},o,r.createElement("div",{className:"social-card-modal__video-embed-wrapper"},r.createElement("iframe",{width:"853",height:"480",src:s,frameBorder:"0",allow:"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture",allowFullScreen:!0,title:"Embedded youtube",className:"social-card-modal__video-embed"}))),r.createElement("footer",{className:"social-card-modal__footer"},r.createElement("a",{href:l,target:"_blank",className:"social-card-modal__open-external-button",rel:"noreferrer"},"View on ",c)))}function D(){return D=Object.assign||function(e){for(var a=1;a<arguments.length;a++){var t=arguments[a];for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r])}return e},D.apply(this,arguments)}function F(e){let{title:a,numberOfCards:t,socialFeedAdapter:n}=e;const c=new g({socialFeedAdapter:n});return r.createElement("div",{className:"social-feed-wrapper"},r.createElement(p,{socialFeedService:c},r.createElement(Z,{title:a,numberOfCards:t})))}function Z(e){let{title:a,numberOfCards:t}=e;const{feedData:c,getFeedData:o}=(0,r.useContext)(u),l=(0,m.Yk)()<=m.S8;return function(e="body",{document:a=d}={}){let t,r=a.querySelector(e),n=[],c=new MutationObserver((e=>{for(let a of e)if("childList"===a.type&&a.addedNodes.length>0){let e=Array.from(a.addedNodes).find((e=>{var a;return null===(a=e.querySelector)||void 0===a?void 0:a.call(e,'[aria-modal="true"], [data-ismodal="true"]')}));if(e){n.push(e);let a=e.querySelector('[aria-modal="true"], [data-ismodal="true"]');null==t||t(),t=i(a)}}else if("childList"===a.type&&a.removedNodes.length>0){let e=Array.from(a.removedNodes),r=n.findIndex((a=>e.includes(a)));if(r>=0)if(t(),n=n.filter(((e,a)=>a!==r)),n.length>0){let e=n[n.length-1].querySelector('[aria-modal="true"], [data-ismodal="true"]');t=i(e)}else t=void 0}}));c.observe(r,{childList:!0})}(),(0,r.useEffect)((()=>{o({count:t})}),[o]),r.createElement(n.N3,{className:"social-feed-wrapper__overlay"},r.createElement("div",{className:"no-wysiwyg social-feed"},r.createElement("div",{className:"social-feed__header"},a),r.createElement("div",{className:"social-feed__body"},c.map(((e,a)=>{return"youtube"===(t={...e,lazyLoadImages:l||a>1}).source?r.createElement(x,D({key:"".concat(t.source," + ").concat(t.createdDate.getTime())},t)):r.createElement(O,D({key:"".concat(t.source," + ").concat(t.createdDate.getTime())},t));var t})))))}},4810:function(e,a,t){function r(e,a){for(var t=e<0?"-":"",r=Math.abs(e).toString();r.length<a;)r="0"+r;return t+r}t.d(a,{Z:function(){return r}})}}]);
//# sourceMappingURL=SocialFeed-8d643aa3ba8fb880c8e6.js.map