/*! For license information please see Notifications-f038e5e0ced511ad1616.js.LICENSE.txt */
"use strict";(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[623],{65525:function(e,t,n){n.d(t,{D:function(){return i}});n(33948),n(17727);class i{constructor(){this.requests=new Map}debounce(e,t){const n=JSON.stringify(e);if(!this.requests.has(n)){const e=t();e.finally((()=>{this.requests.delete(n)})),this.requests.set(n,e)}return this.requests.get(n)}get(e){return this.requests.get(JSON.stringify(e))}}},331:function(e,t,n){n.d(t,{Z:function(){return i}});n(15306),n(82472),n(3462),n(33824);function i(){return([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,(e=>(e^crypto.getRandomValues(new Uint8Array(1))[0]&15>>e/4).toString(16)))}},11321:function(e,t,n){n.d(t,{Z:function(){return s}});var i=n(67294),a=n(12988),o=n(34708),c=n(49641);function r(){return r=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},r.apply(this,arguments)}function s(e){let{titleId:t,title:n,onClose:o,children:r,className:s}=e;return i.createElement(a.Xj,null,i.createElement("div",{className:"no-wysiwyg modal-wrapper ".concat(s?"".concat(s,"-wrapper"):"")},i.createElement(c.MT,{contain:!0,restoreFocus:!0,autoFocus:!0},i.createElement(l,{titleId:t,title:n,onClose:o,className:s},r))))}function l(e){let{titleId:t,title:n,onClose:s,children:l,className:d}=e;const m={"aria-describedby":t,title:n,onClose:s,isDismissable:!0,isOpen:!0},f=i.useRef(),u=i.useRef(),p=(0,c.bO)(),{overlayProps:E,underlayProps:N}=(0,a.Ir)(m,u);(0,a.tk)();const{modalProps:g}=(0,a.dd)(),{dialogProps:_,titleProps:h}=(0,o.R)(m,u);return(0,i.useEffect)((()=>{f.current.removeAttribute("hidden"),p.focusFirst()}),[f]),i.createElement("div",r({ref:f},N,{hidden:!0,className:"modal ".concat(d||"")}),i.createElement("div",r({ref:u},E,_,g,{"aria-modal":"true",tabIndex:"-1",className:"modal__content ".concat(d?"".concat(d,"__content"):"")}),t?"":i.createElement("h2",r({},h,{className:"".concat(d?"".concat(d,"__title"):"")}),n),l))}},6175:function(e,t,n){n.d(t,{Z:function(){return o}});n(33948);var i=n(67294),a=n(64663);function o(){const[e,t]=(0,i.useState)(!1),n=(0,i.useRef)();let{buttonProps:o}=(0,a.U)({onPress:()=>t(!0)},n);return o={...o,role:"button",tabIndex:"0","aria-label":"Open in modal"},delete o.type,{openModalRef:n,modalOpenProps:o,isModalOpen:e,setIsModalOpen:t}}},42501:function(e,t,n){n.r(t),n.d(t,{default:function(){return k}});n(33948);var i=n(67294),a=n(12988),o=n(331);const c=(0,i.createContext)({isLoading:!1,notifications:[],getNotifications:null,isMoreNotifications:!1,setRead:null,unreadNotifications:0,getUnreadNotificationsCount:null,pinnedNotifications:[],getPinnedNotifications:null,setPinned:null}),r=e=>{let{children:t,notificationService:n}=e;const[a,o]=(0,i.useState)(!1),[r,s]=(0,i.useState)([]),[l,d]=(0,i.useState)([]),[m,f]=(0,i.useState)(!1),[u,p]=(0,i.useState)(0),E=(0,i.useCallback)((e=>(o(!0),n.getUnreadNotificationsCount(e).then((e=>{p(e),o(!1)})))),[]),N=(0,i.useCallback)((e=>(o(!0),n.getPinnedNotifications(e).then((e=>{s(e),o(!1)})))),[]),g=(0,i.useCallback)((e=>(o(!0),n.getNotifications(e).then((t=>{!e.start||e.reload?d(t.notifications):d([...l].concat(t.notifications)),f(t.next),o(!1)})))),[l]);return i.createElement(c.Provider,{value:{isLoading:a,notifications:l,getNotifications:g,isMoreNotifications:m,setRead:e=>(o(!0),n.setRead(e).then((e=>{const t=[...l],n=l.findIndex((t=>t.id===e.id));-1!==n&&(t[n]=e,d(t),e.read&&p(u-1)),o(!1)}))),unreadNotificationsCount:u,getUnreadNotificationsCount:E,pinnedNotifications:r,getPinnedNotifications:N,setPinned:e=>(o(!0),n.setPinned(e).then((t=>{let n=[...l],i=[...r];if(e.pinned)n=l.filter((e=>e.id!==t.id)),i.push(t),i.sort(((e,t)=>t.createdDate.getTime()-e.createdDate.getTime())),d(n);else{i=r.filter((e=>e.id!==t.id));const e=n.slice(-1).pop();!e||t.createdDate.getTime()<e.createdDate.getTime()?g({reload:!0,start:0,max:l.length}):(n.push(t),n.sort(((e,t)=>t.createdDate.getTime()-e.createdDate.getTime())),d(n))}s(i),o(!1)})))}},t)};var s=n(65525);class l{constructor(e){if(!e)throw new Error("args is required when instantiating a new NotificationService");["notificationAdapter"].forEach((t=>{if(!e[t])throw new Error("".concat(t," property is required when instantiating a new NotificationService"))})),this.promiseDebouncer=new s.D,this.notificationAdapter=e.notificationAdapter}getNotifications(e){return this.promiseDebouncer.debounce({method:"getNotifications",...e},(()=>this.notificationAdapter.getNotifications(e)))}getPinnedNotifications(e){return this.promiseDebouncer.debounce({method:"gePinnedNotifications",...e},(()=>this.notificationAdapter.getPinnedNotifications(e)))}getUnreadNotificationsCount(e){return this.promiseDebouncer.debounce({method:"getUnreadNotificationsCount",...e},(()=>this.notificationAdapter.getUnreadNotificationsCount(e)))}setRead(e){return this.notificationAdapter.setRead(e)}setPinned(e){return this.notificationAdapter.setPinned(e)}}var d=n(13122),m=n(11321),f=n(6175);function u(){return u=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},u.apply(this,arguments)}function p(e){const{title:t,subtitle:n,body:a,read:o,onClick:c}=e,{openModalRef:r,modalOpenProps:s,isModalOpen:l,setIsModalOpen:d}=(0,f.Z)();return(0,i.useEffect)((()=>{l&&c()}),[l]),i.createElement(i.Fragment,null,i.createElement("div",u({},s,{ref:r,className:"notification-content ".concat(o?"":"notification-content--unread")}),i.createElement("div",{className:"notification-content__header"},i.createElement("h2",{className:"notification-content__title"},t)),i.createElement("div",{className:"notification-content__body"},n?i.createElement("div",{className:"notification-content__subtitle"},t):i.createElement(i.Fragment,null),i.createElement("div",{className:"notification-content__description"},a))),l&&i.createElement(E,u({},e,{handleModalClose:()=>{d(!1)}})))}function E(e){let{type:t,title:n,subtitle:a,createdDate:c,body:r,pinned:s,handleModalClose:l,onPin:f,pinningAlowed:u}=e,p=(0,d.Z)(c,new Date,{addSuffix:!0});["minute","hour"].some((e=>p.includes(e)))&&(p="Today");const E=(0,o.Z)();return i.createElement(m.Z,{titleId:E,onClose:e=>{l(e)}},i.createElement("div",{className:"notification-content-modal notification-content-modal--".concat(t)},i.createElement("header",{className:"notification-content-modal__header"},i.createElement("h2",{id:E,className:"notification-content-modal__title"},n)),i.createElement("div",{className:"notification-content-modal__body"},i.createElement("div",{className:"notification-content-modal__date-distance"},p),a?i.createElement("div",{className:"notification-content-modal__subtitle"},a):i.createElement(i.Fragment,null),i.createElement("div",{className:"notification-content-modal__description"},r)),u&&i.createElement("footer",{className:"notification-content-modal__footer"},i.createElement("button",{type:"button",onClick:f,className:"notification-content-modal__pin"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#pin"})),s?"Unpin it":"Pin it"))))}function N(){return N=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},N.apply(this,arguments)}function g(e){const{title:t,course:n,body:a,read:o,onClick:c}=e,{openModalRef:r,modalOpenProps:s,isModalOpen:l,setIsModalOpen:d}=(0,f.Z)();return(0,i.useEffect)((()=>{l&&c()}),[l]),i.createElement(i.Fragment,null,i.createElement("div",N({},s,{ref:r,className:"notification-content ".concat(o?"":"notification-content--unread")}),i.createElement("div",{className:"notification-content__header"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#announcement"})),i.createElement("h2",{className:"notification-content__title"},n?"".concat(n," | "):"","Announcement")),i.createElement("div",{className:"notification-content__body"},i.createElement("div",{className:"notification-content__subtitle"},t),i.createElement("div",{className:"notification-content__description"},a))),l&&i.createElement(_,N({},e,{handleModalClose:()=>{d(!1)}})))}function _(e){let{type:t,title:n,course:a,createdDate:c,body:r,pinned:s,handleModalClose:l,onPin:f,pinningAlowed:u}=e,p=(0,d.Z)(c,new Date,{addSuffix:!0});["minute","hour"].some((e=>p.includes(e)))&&(p="Today");const E=(0,o.Z)();return i.createElement(m.Z,{titleId:E,onClose:l},i.createElement("div",{className:"notification-content-modal notification-content-modal--".concat(t)},i.createElement("header",{className:"notification-content-modal__header"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#announcement"})),i.createElement("h2",{id:E,className:"notification-content-modal__title"},a?"".concat(a," | "):""," Announcement")),i.createElement("div",{className:"notification-content-modal__body"},i.createElement("div",{className:"notification-content-modal__date-distance"},p),n?i.createElement("div",{className:"notification-content-modal__subtitle"},n):i.createElement(i.Fragment,null),i.createElement("div",{className:"notification-content-modal__description"},r)),u&&i.createElement("footer",{className:"notification-content-modal__footer"},i.createElement("button",{type:"button",onClick:f,className:"notification-content-modal__pin"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#pin"})),s?"Unpin it":"Pin it"))))}var h=n(87553);function v(){return v=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},v.apply(this,arguments)}function b(e){const{title:t,course:n,body:a,read:o,onClick:c}=e,{openModalRef:r,modalOpenProps:s,isModalOpen:l,setIsModalOpen:d}=(0,f.Z)();return(0,i.useEffect)((()=>{l&&c()}),[l]),i.createElement(i.Fragment,null,i.createElement("div",v({},s,{ref:r,className:"notification-content ".concat(o?"":"notification-content--unread")}),i.createElement("div",{className:"notification-content__header"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#assignment"})),i.createElement("h2",{className:"notification-content__title"},n?"".concat(n," | "):"","Assignment")),i.createElement("div",{className:"notification-content__body"},t&&i.createElement("div",{className:"notification-content__subtitle"},t),i.createElement("div",{className:"notification-content__description"},a))),l&&i.createElement(y,v({},e,{handleModalClose:()=>{d(!1)}})))}function y(e){let{type:t,course:n,createdDate:a,dueDate:c,body:r,externalLink:s,pinned:l,handleModalClose:f,onPin:u,pinningAlowed:p}=e,E=(0,d.Z)(a,new Date,{addSuffix:!0});["minute","hour"].some((e=>E.includes(e)))&&(E="Today");const N=(0,h.Z)(c,"dd MMM"),g=(0,o.Z)();return i.createElement(m.Z,{titleId:g,onClose:f},i.createElement("div",{className:"notification-content-modal notification-content-modal--".concat(t)},i.createElement("header",{className:"notification-content-modal__header"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#assignment"})),i.createElement("h2",{id:g,className:"notification-content-modal__title"},n?"".concat(n," | "):""," Assignment")),i.createElement("div",{className:"notification-content-modal__body"},i.createElement("div",{className:"notification-content-modal__date-distance"},E),c?i.createElement("div",{className:"notification-content-modal__subtitle"},"Due ",N):i.createElement(i.Fragment,null),i.createElement("div",{className:"notification-content-modal__description"},r),i.createElement("a",{href:s,className:"notification-content-modal__link"},i.createElement("svg",{className:"svg-icon svg-icon--small"},i.createElement("title",null,"External link"),i.createElement("use",{href:"#external"})),"View in Canvas")),p&&i.createElement("footer",{className:"notification-content-modal__footer"},i.createElement("button",{type:"button",onClick:u,className:"notification-content-modal__pin"},i.createElement("svg",{"aria-hidden":"true",className:"svg-icon"},i.createElement("use",{href:"#pin"})),l?"Unpin it":"Pin it"))))}function P(e){const{type:t}=e;switch(t){case"announcement":return i.createElement(g,e);case"assignment":return i.createElement(b,e);default:return i.createElement(p,e)}}function w(){return w=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},w.apply(this,arguments)}function C(e){let{notifications:t,showLimit:n,pinnedList:a,pinningAlowed:o,setRead:c,setPinned:r}=e,s=t,l="";return n>-1&&(s=s.slice(0,n)),s.map(((e,n)=>{const{pinned:s}=e;let m,f=!1;return a||(m=(0,d.Z)(e.createdDate,new Date,{addSuffix:!0}),["minute","hour"].some((e=>m.includes(e)))&&(m="Today"),l!==m&&(f=!0,l=m)),i.createElement("li",{key:"".concat(e.createdDate.getTime()),className:"notification-item ".concat(s?"notification-item--pinned":"")},0===n&&a?i.createElement("div",{className:"notification-item__pinned"},"Pinned (".concat(t.length,")")):i.createElement(i.Fragment,null," "),!a&&f?i.createElement("div",{className:"notification-item__distance"},m):i.createElement(i.Fragment,null," "),i.createElement("div",{className:"notification-item__body"},i.createElement(P,w({},e,{onClick:()=>{e.read||c(e)},onPin:()=>r(e),pinningAlowed:o})),o?i.createElement("button",{type:"button",onClick:()=>r(e),className:"notification-item__icon ".concat(s?"notification-item__icon--pinned":"")},i.createElement("svg",{className:"svg-icon"},i.createElement("title",null,s?"Unpin":"Pin"," notification"),i.createElement("use",{href:"#pin"}))):i.createElement(i.Fragment,null)))}))}var O=n(58265);function M(){return M=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},M.apply(this,arguments)}function k(e){let{popover:t,title:n,enablePinnedNotifications:o,pinnedLimit:c,notificationsLimit:s,showUnreadIndicator:d,notificationAdapter:m}=e;const f=new l({notificationAdapter:m});return i.createElement(a.N3,{className:"notifications-wrapper"},i.createElement(r,{notificationService:f},i.createElement(D,{popover:t,title:n,enablePinnedNotifications:o,showUnreadIndicator:d,notificationsLimit:s,pinnedLimit:c})))}function D(e){let{popover:t,title:n,enablePinnedNotifications:a,showUnreadIndicator:r,notificationsLimit:s,pinnedLimit:l}=e;const{notifications:d,getNotifications:m,isMoreNotifications:f,pinnedNotifications:u,getPinnedNotifications:p,setPinned:E,unreadNotificationsCount:N,getUnreadNotificationsCount:g,setRead:_}=(0,i.useContext)(c),[h,v]=(0,i.useState)(!1);(0,i.useEffect)((()=>{a&&p(),r&&g(),m({max:s,includePinned:!a})}),[a,s]);const b=(0,i.useCallback)((e=>{_({...e,read:!0})}),[_]),y=(0,i.useCallback)((e=>{E({...e,pinned:!e.pinned})}),[E]),P=(0,i.useCallback)((()=>{v(!h)}),[v,h]),w=(0,i.useCallback)((()=>{m({start:d.length,max:s,includePinned:!a})}),[d,s,a]),k=(0,o.Z)(),D=i.createElement("div",{className:"no-wysiwyg notifications"},i.createElement("div",{className:"notifications__header"},i.createElement("h1",{id:k,className:"notifications__title"},n)),i.createElement("div",{className:"notifications__body"},a&&u.length>0&&i.createElement("ul",{"aria-label":"Pinned notifications",className:"notifications__list"},i.createElement(C,{notifications:u,showLimit:h?-1:l,showMore:P,pinnedList:!0,pinningAlowed:!0,setRead:b,setPinned:y})),a&&u.length>l&&i.createElement("button",{type:"button",onClick:P,className:"notifications__expand-pinned"},"Show ",h?"less":"more"," (",u.length-l,")"),i.createElement("ul",{"aria-label":"Notifications",className:"notifications__list"},i.createElement(C,{notifications:d,pinningAlowed:a,setRead:b,setPinned:y})),f&&i.createElement("button",{type:"button",onClick:w,className:"notifications__more"},"Show more")));return t?i.createElement(O.Z,{titleId:k,trigger:e=>{let{props:t,ref:n}=e;return i.createElement("button",M({ref:n},t,{type:"button",className:"notifications-wrapper__action"}),r&&N>0&&i.createElement("div",{"aria-label":"unread notifications",className:"notifications-wrapper__unread"},N),i.createElement("svg",{className:"svg-icon"},i.createElement("title",null,"View notifications"),i.createElement("use",{href:"#notification"})))},className:"notification-popover"},D):D}},58265:function(e,t,n){n.d(t,{Z:function(){return u}});n(33948);var i=n(67294),a=n(45697),o=n.n(a),c=n(12988),r=n(64663),s=n(34708),l=n(49641),d=n(3366);function m(){return m=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},m.apply(this,arguments)}const f=i.forwardRef(((e,t)=>{let{titleId:n,title:a,children:o,isOpen:r,onClose:f,className:u,...p}=e;const{overlayProps:E}=(0,c.Ir)({onClose:f,isOpen:r,isDismissable:!0},t),{modalProps:N}=(0,c.dd)(),{dialogProps:g,titleProps:_}=(0,s.R)({"aria-describedby":n},t);return i.createElement(l.MT,{contain:!0,restoreFocus:!0},i.createElement("div",m({},(0,d.dG)(E,g,p,N),{ref:t,className:"popover__dialog ".concat(u,"__dialog")}),n?"":i.createElement("h2",m({},_,{className:"popover__title ".concat(u,"__title")}),a),o,i.createElement(c.U4,{onDismiss:f})))}));function u(e){let{titleId:t,title:n,placement:a,trigger:o,className:s,children:l}=e;const[u,p]=(0,i.useState)(!1),E=i.useRef(),N=i.useRef(),{triggerProps:g,overlayProps:_}=(0,c.IB)({type:"dialog"},{isOpen:u},E),{overlayProps:h}=(0,c.tN)({targetRef:E,overlayRef:N,placement:a||"bottom right",offset:5,isOpen:u});delete h.style.zIndex;for(const[e,t]of Object.entries(h.style))h.style["--popover-".concat(e)]=isNaN(t)?t:"".concat(t,"px"),delete h.style[e];const{buttonProps:v}=(0,r.U)({onPress:()=>p(!0)},E),b=o({props:{...(0,d.dG)(v,g)},ref:E});return i.createElement(i.Fragment,null,b,u&&i.createElement(c.Xj,{className:"popover ".concat(s)},i.createElement(f,m({},_,h,{ref:N,titleId:t,title:n,isOpen:!0,onClose:()=>{p(!1)},className:s}),l)))}u.propTypes={titleId:o().string,title:o().string,trigger:o().func,className:o().string},u.defaultProps={titleId:"",title:"popover",trigger:e=>{let{props:t,ref:n}=e;return i.createElement("button",m({},t,{ref:n}),"Open popover")},className:"popover"}}}]);
//# sourceMappingURL=Notifications-f038e5e0ced511ad1616.js.map