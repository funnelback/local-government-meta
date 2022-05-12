"use strict";(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[623],{331:function(e,t,n){n.d(t,{Z:function(){return a}});n(15306),n(82472),n(3462),n(33824);function a(){return([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,(e=>(e^crypto.getRandomValues(new Uint8Array(1))[0]&15>>e/4).toString(16)))}},11321:function(e,t,n){n.d(t,{Z:function(){return r}});var a=n(67294),i=n(12988),o=n(34708),c=n(49641);function l(){return l=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},l.apply(this,arguments)}function r(e){let{titleId:t,title:n,onClose:o,children:l,className:r}=e;return a.createElement(i.Xj,null,a.createElement("div",{className:"no-wysiwyg modal-wrapper ".concat(r?"".concat(r,"-wrapper"):"")},a.createElement(c.MT,{contain:!0,restoreFocus:!0,autoFocus:!0},a.createElement(s,{titleId:t,title:n,onClose:o,className:r},l))))}function s(e){let{titleId:t,title:n,onClose:r,children:s,className:m}=e;const d={"aria-describedby":t,title:n,onClose:r,isDismissable:!0,isOpen:!0},u=a.useRef(),f=a.useRef(),p=(0,c.bO)(),{overlayProps:E,underlayProps:_}=(0,i.Ir)(d,f);(0,i.tk)();const{modalProps:v}=(0,i.dd)(),{dialogProps:N,titleProps:g}=(0,o.R)(d,f);return(0,a.useEffect)((()=>{u.current.removeAttribute("hidden"),p.focusFirst()}),[u]),a.createElement("div",l({ref:u},_,{hidden:!0,className:"modal ".concat(m||"")}),a.createElement("div",l({ref:f},E,N,v,{"aria-modal":"true",tabIndex:"-1",className:"modal__content ".concat(m?"".concat(m,"__content"):"")}),t?"":a.createElement("h2",l({},g,{className:"".concat(m?"".concat(m,"__title"):"")}),n),s))}},6175:function(e,t,n){n.d(t,{Z:function(){return o}});n(33948);var a=n(67294),i=n(64663);function o(){const[e,t]=(0,a.useState)(!1),n=(0,a.useRef)();let{buttonProps:o}=(0,i.U)({onPress:()=>t(!0)},n);return o={...o,role:"button",tabIndex:"0","aria-label":"Open in modal"},delete o.type,{openModalRef:n,modalOpenProps:o,isModalOpen:e,setIsModalOpen:t}}},80692:function(e,t,n){n.r(t),n.d(t,{default:function(){return w}});n(33948);var a=n(67294),i=n(12988),o=n(331),c=n(21919),l=n(13122),r=n(11321),s=n(6175);function m(){return m=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},m.apply(this,arguments)}function d(e){const{title:t,subtitle:n,body:i,read:o,onClick:c}=e,{openModalRef:l,modalOpenProps:r,isModalOpen:d,setIsModalOpen:f}=(0,s.Z)();return(0,a.useEffect)((()=>{d&&c()}),[d]),a.createElement(a.Fragment,null,a.createElement("div",m({},r,{ref:l,className:"notification-content ".concat(o?"":"notification-content--unread")}),a.createElement("div",{className:"notification-content__header"},a.createElement("h2",{className:"notification-content__title"},t)),a.createElement("div",{className:"notification-content__body"},n?a.createElement("div",{className:"notification-content__subtitle"},t):a.createElement(a.Fragment,null),a.createElement("div",{className:"notification-content__description"},i))),d&&a.createElement(u,m({},e,{handleModalClose:()=>{f(!1)}})))}function u(e){let{type:t,title:n,subtitle:i,createdDate:c,body:s,pinned:m,handleModalClose:d,onPin:u,pinningAlowed:f}=e,p=(0,l.Z)(c,new Date,{addSuffix:!0});["minute","hour"].some((e=>p.includes(e)))&&(p="Today");const E=(0,o.Z)();return a.createElement(r.Z,{titleId:E,onClose:e=>{d(e)}},a.createElement("div",{className:"notification-content-modal notification-content-modal--".concat(t)},a.createElement("header",{className:"notification-content-modal__header"},a.createElement("h2",{id:E,className:"notification-content-modal__title"},n)),a.createElement("div",{className:"notification-content-modal__body"},a.createElement("div",{className:"notification-content-modal__date-distance"},p),i?a.createElement("div",{className:"notification-content-modal__subtitle"},i):a.createElement(a.Fragment,null),a.createElement("div",{className:"notification-content-modal__description"},s)),f&&a.createElement("footer",{className:"notification-content-modal__footer"},a.createElement("button",{type:"button",onClick:u,className:"notification-content-modal__pin"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#pin"})),m?"Unpin it":"Pin it"))))}function f(){return f=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},f.apply(this,arguments)}function p(e){const{title:t,course:n,body:i,read:o,onClick:c}=e,{openModalRef:l,modalOpenProps:r,isModalOpen:m,setIsModalOpen:d}=(0,s.Z)();return(0,a.useEffect)((()=>{m&&c()}),[m]),a.createElement(a.Fragment,null,a.createElement("div",f({},r,{ref:l,className:"notification-content ".concat(o?"":"notification-content--unread")}),a.createElement("div",{className:"notification-content__header"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#announcement"})),a.createElement("h2",{className:"notification-content__title"},n?"".concat(n," | "):"","Announcement")),a.createElement("div",{className:"notification-content__body"},a.createElement("div",{className:"notification-content__subtitle"},t),a.createElement("div",{className:"notification-content__description"},i))),m&&a.createElement(E,f({},e,{handleModalClose:()=>{d(!1)}})))}function E(e){let{type:t,title:n,course:i,createdDate:c,body:s,pinned:m,handleModalClose:d,onPin:u,pinningAlowed:f}=e,p=(0,l.Z)(c,new Date,{addSuffix:!0});["minute","hour"].some((e=>p.includes(e)))&&(p="Today");const E=(0,o.Z)();return a.createElement(r.Z,{titleId:E,onClose:d},a.createElement("div",{className:"notification-content-modal notification-content-modal--".concat(t)},a.createElement("header",{className:"notification-content-modal__header"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#announcement"})),a.createElement("h2",{id:E,className:"notification-content-modal__title"},i?"".concat(i," | "):""," Announcement")),a.createElement("div",{className:"notification-content-modal__body"},a.createElement("div",{className:"notification-content-modal__date-distance"},p),n?a.createElement("div",{className:"notification-content-modal__subtitle"},n):a.createElement(a.Fragment,null),a.createElement("div",{className:"notification-content-modal__description"},s)),f&&a.createElement("footer",{className:"notification-content-modal__footer"},a.createElement("button",{type:"button",onClick:u,className:"notification-content-modal__pin"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#pin"})),m?"Unpin it":"Pin it"))))}var _=n(87553);function v(){return v=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},v.apply(this,arguments)}function N(e){const{title:t,course:n,body:i,read:o,onClick:c}=e,{openModalRef:l,modalOpenProps:r,isModalOpen:m,setIsModalOpen:d}=(0,s.Z)();return(0,a.useEffect)((()=>{m&&c()}),[m]),a.createElement(a.Fragment,null,a.createElement("div",v({},r,{ref:l,className:"notification-content ".concat(o?"":"notification-content--unread")}),a.createElement("div",{className:"notification-content__header"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#assignment"})),a.createElement("h2",{className:"notification-content__title"},n?"".concat(n," | "):"","Assignment")),a.createElement("div",{className:"notification-content__body"},t&&a.createElement("div",{className:"notification-content__subtitle"},t),a.createElement("div",{className:"notification-content__description"},i))),m&&a.createElement(g,v({},e,{handleModalClose:()=>{d(!1)}})))}function g(e){let{type:t,course:n,createdDate:i,dueDate:c,body:s,externalLink:m,pinned:d,handleModalClose:u,onPin:f,pinningAlowed:p}=e,E=(0,l.Z)(i,new Date,{addSuffix:!0});["minute","hour"].some((e=>E.includes(e)))&&(E="Today");const v=(0,_.Z)(c,"dd MMM"),N=(0,o.Z)();return a.createElement(r.Z,{titleId:N,onClose:u},a.createElement("div",{className:"notification-content-modal notification-content-modal--".concat(t)},a.createElement("header",{className:"notification-content-modal__header"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#assignment"})),a.createElement("h2",{id:N,className:"notification-content-modal__title"},n?"".concat(n," | "):""," Assignment")),a.createElement("div",{className:"notification-content-modal__body"},a.createElement("div",{className:"notification-content-modal__date-distance"},E),c?a.createElement("div",{className:"notification-content-modal__subtitle"},"Due ",v):a.createElement(a.Fragment,null),a.createElement("div",{className:"notification-content-modal__description"},s),a.createElement("a",{href:m,className:"notification-content-modal__link"},a.createElement("svg",{className:"svg-icon svg-icon--small"},a.createElement("title",null,"External link"),a.createElement("use",{href:"#external"})),"View in Canvas")),p&&a.createElement("footer",{className:"notification-content-modal__footer"},a.createElement("button",{type:"button",onClick:f,className:"notification-content-modal__pin"},a.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},a.createElement("use",{href:"#pin"})),d?"Unpin it":"Pin it"))))}function h(e){const{type:t}=e;switch(t){case"announcement":return a.createElement(p,e);case"assignment":return a.createElement(N,e);default:return a.createElement(d,e)}}function b(){return b=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},b.apply(this,arguments)}function y(e){let{notifications:t,showLimit:n,pinnedList:i,pinningAlowed:o,setRead:c,setPinned:r}=e,s=t,m="";return n>-1&&(s=s.slice(0,n)),s.map(((e,n)=>{const{pinned:s}=e;let d,u=!1;return i||(d=(0,l.Z)(e.createdDate,new Date,{addSuffix:!0}),["minute","hour"].some((e=>d.includes(e)))&&(d="Today"),m!==d&&(u=!0,m=d)),a.createElement("li",{key:"".concat(e.id),className:"notification-item ".concat(s?"notification-item--pinned":"")},0===n&&i?a.createElement("div",{className:"notification-item__pinned"},"Pinned (".concat(t.length,")")):a.createElement(a.Fragment,null," "),!i&&u?a.createElement("div",{className:"notification-item__distance"},d):a.createElement(a.Fragment,null," "),a.createElement("div",{className:"notification-item__body"},a.createElement(h,b({},e,{onClick:()=>{e.read||c(e)},onPin:()=>r(e),pinningAlowed:o})),o?a.createElement("button",{type:"button",onClick:()=>r(e),className:"notification-item__icon ".concat(s?"notification-item__icon--pinned":"")},a.createElement("svg",{className:"svg-icon"},a.createElement("title",null,s?"Unpin":"Pin"," notification"),a.createElement("use",{href:"#pin"}))):a.createElement(a.Fragment,null)))}))}var P=n(58265);function O(){return O=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},O.apply(this,arguments)}function w(e){let{popover:t,title:n,enablePinnedNotifications:l,showUnreadIndicator:r,notificationsLimit:s,pinnedLimit:m}=e;const{notifications:d,getNotifications:u,isMoreNotifications:f,pinnedNotifications:p,getPinnedNotifications:E,setPinned:_,unreadNotificationsCount:v,getUnreadNotificationsCount:N,setRead:g}=(0,a.useContext)(c.Z),[h,b]=(0,a.useState)(!1);(0,a.useEffect)((()=>{l&&E(),r&&N(),u({max:s,includePinned:!l})}),[l,s]);const w=(0,a.useCallback)((e=>{g({...e,read:!0})}),[g]),C=(0,a.useCallback)((e=>{_({...e,pinned:!e.pinned})}),[_]),M=(0,a.useCallback)((()=>{b(!h)}),[b,h]),I=(0,a.useCallback)((()=>{u({start:d.length,max:s,includePinned:!l})}),[d,s,l]),k=(0,o.Z)();let R=a.createElement("div",{className:"no-wysiwyg notifications"},a.createElement("div",{className:"notifications__header"},a.createElement("h1",{id:k,className:"notifications__title"},n)),a.createElement("div",{className:"notifications__body"},l&&p.length>0&&a.createElement("ul",{"aria-label":"Pinned notifications",className:"notifications__list"},a.createElement(y,{notifications:p,showLimit:h?-1:m,showMore:M,pinnedList:!0,pinningAlowed:!0,setRead:w,setPinned:C})),l&&p.length>m&&a.createElement("button",{type:"button",onClick:M,className:"notifications__expand-pinned"},"Show ",h?"less":"more"," (",p.length-m,")"),a.createElement("ul",{"aria-label":"Notifications",className:"notifications__list"},a.createElement(y,{notifications:d,pinningAlowed:l,setRead:w,setPinned:C})),f&&a.createElement("button",{type:"button",onClick:I,className:"notifications__more"},"Show more")));return t&&(R=a.createElement(P.Z,{titleId:k,trigger:e=>{let{props:t,ref:n}=e;return a.createElement("button",O({ref:n},t,{type:"button",className:"notifications-wrapper__action"}),r&&v>0&&a.createElement("div",{"aria-label":"unread notifications",className:"notifications-wrapper__unread"},v),a.createElement("svg",{className:"svg-icon"},a.createElement("title",null,"View notifications"),a.createElement("use",{href:"#notification"})))},className:"notification-popover"},R)),a.createElement(i.N3,{className:"notifications-wrapper"},R)}},58265:function(e,t,n){n.d(t,{Z:function(){return f}});n(33948);var a=n(67294),i=n(45697),o=n.n(i),c=n(12988),l=n(64663),r=n(34708),s=n(49641),m=n(3366);function d(){return d=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e},d.apply(this,arguments)}const u=a.forwardRef(((e,t)=>{let{triggerRef:n,titleId:i,title:o,children:l,isOpen:u,onClose:f,className:p,...E}=e;const{overlayProps:_}=(0,c.Ir)({onClose:f,isOpen:u,isDismissable:!0,shouldCloseOnInteractOutside:e=>!e.closest('[data-overlay-container]:not([aria-hidden="true"])')&&(!!n.current.contains(e)||(f(),!1))},t),{modalProps:v}=(0,c.dd)(),{dialogProps:N,titleProps:g}=(0,r.R)({"aria-describedby":i},t);return a.createElement(s.MT,{contain:!0,restoreFocus:!0},a.createElement("div",d({},(0,m.dG)(_,N,E,v),{ref:t,className:"popover__dialog ".concat(p,"__dialog")}),i?"":a.createElement("h2",d({},g,{className:"popover__title ".concat(p,"__title")}),o),l,a.createElement(c.U4,{onDismiss:f})))}));function f(e){let{titleId:t,title:n,placement:i,trigger:o,className:r,children:s}=e;const[f,p]=(0,a.useState)(!1),E=a.useRef(),_=a.useRef(),{triggerProps:v,overlayProps:N}=(0,c.IB)({type:"dialog"},{isOpen:f},E),{overlayProps:g}=(0,c.tN)({targetRef:E,overlayRef:_,placement:i||"bottom right",offset:5,isOpen:f});delete g.style.zIndex;for(const[e,t]of Object.entries(g.style))g.style["--popover-".concat(e)]=isNaN(t)?t:"".concat(t,"px"),delete g.style[e];const{buttonProps:h}=(0,l.U)({onPress:()=>p(!0)},E),b=o({props:{...(0,m.dG)(h,v)},ref:E});return a.createElement(a.Fragment,null,b,f&&a.createElement(c.Xj,{className:"popover ".concat(r)},a.createElement(u,d({},N,g,{ref:_,triggerRef:E,titleId:t,title:n,isOpen:!0,onClose:()=>{p(!1)},className:r}),s)))}f.propTypes={titleId:o().string,title:o().string,trigger:o().func,className:o().string},f.defaultProps={titleId:"",title:"popover",trigger:e=>{let{props:t,ref:n}=e;return a.createElement("button",d({},t,{ref:n}),"Open popover")},className:"popover"}}}]);
//# sourceMappingURL=Notifications-9e1d4679ebf45615f880.js.map