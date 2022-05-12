"use strict";(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[354],{27354:function(e,t,n){n.d(t,{r7:function(){return g},KK:function(){return w},Jz:function(){return R},L_:function(){return F},Fc:function(){return x},v5:function(){return N}});var r=n(67294),o=n(3366),i=n(63366),u=n(87462);let s="default",a="",c=new WeakMap;function l(e){(0,o.gn)()?("default"===s&&(a=document.documentElement.style.webkitUserSelect,document.documentElement.style.webkitUserSelect="none"),s="disabled"):e&&(c.set(e,e.style.userSelect),e.style.userSelect="none")}function d(e){if((0,o.gn)()){if("disabled"!==s)return;s="restoring",setTimeout((()=>{(0,o.QB)((()=>{"restoring"===s&&("none"===document.documentElement.style.webkitUserSelect&&(document.documentElement.style.webkitUserSelect=a||""),a="",s="default")}))}),300)}else if(e&&c.has(e)){let t=c.get(e);"none"===e.style.userSelect&&(e.style.userSelect=t),""===e.getAttribute("style")&&e.removeAttribute("style"),c.delete(e)}}function f(e){return!(0!==e.mozInputSource||!e.isTrusted)||0===e.detail&&!e.pointerType}const p=r.createContext(null);function g(e){let t=function(e){let t=(0,r.useContext)(p);if(t){let{register:n}=t,r=(0,i.Z)(t,["register"]);e=(0,o.dG)(r,e),n()}return(0,o.lE)(t,e.ref),e}(e),{onPress:n,onPressChange:u,onPressStart:s,onPressEnd:a,onPressUp:c,isDisabled:g,isPressed:w,preventFocusOnPress:T,shouldCancelOnPointerExit:b,allowTextSelectionOnPress:L}=t,S=(0,i.Z)(t,["onPress","onPressChange","onPressStart","onPressEnd","onPressUp","isDisabled","isPressed","preventFocusOnPress","shouldCancelOnPointerExit","allowTextSelectionOnPress","ref"]),O=(0,r.useRef)(null);O.current={onPress:n,onPressChange:u,onPressStart:s,onPressEnd:a,onPressUp:c,isDisabled:g,shouldCancelOnPointerExit:b};let[C,D]=(0,r.useState)(!1),M=(0,r.useRef)({isPressed:!1,ignoreEmulatedMouseEvents:!1,ignoreClickAfterPress:!1,didFirePressStart:!1,activePointerId:null,target:null,isOverTarget:!1,pointerType:null}),{addGlobalListener:K,removeAllGlobalListeners:k}=(0,o.xi)(),I=(0,r.useMemo)((()=>{let e=M.current,t=(t,n)=>{let{onPressStart:r,onPressChange:o,isDisabled:i}=O.current;i||e.didFirePressStart||(r&&r({type:"pressstart",pointerType:n,target:t.currentTarget,shiftKey:t.shiftKey,metaKey:t.metaKey,ctrlKey:t.ctrlKey,altKey:t.altKey}),o&&o(!0),e.didFirePressStart=!0,D(!0))},n=function(t,n,r){void 0===r&&(r=!0);let{onPressEnd:o,onPressChange:i,onPress:u,isDisabled:s}=O.current;e.didFirePressStart&&(e.ignoreClickAfterPress=!0,e.didFirePressStart=!1,o&&o({type:"pressend",pointerType:n,target:t.currentTarget,shiftKey:t.shiftKey,metaKey:t.metaKey,ctrlKey:t.ctrlKey,altKey:t.altKey}),i&&i(!1),D(!1),u&&r&&!s&&u({type:"press",pointerType:n,target:t.currentTarget,shiftKey:t.shiftKey,metaKey:t.metaKey,ctrlKey:t.ctrlKey,altKey:t.altKey}))},r=(e,t)=>{let{onPressUp:n,isDisabled:r}=O.current;r||n&&n({type:"pressup",pointerType:t,target:e.currentTarget,shiftKey:e.shiftKey,metaKey:e.metaKey,ctrlKey:e.ctrlKey,altKey:e.altKey})},i=t=>{e.isPressed&&(e.isOverTarget&&n(h(e.target,t),e.pointerType,!1),e.isPressed=!1,e.isOverTarget=!1,e.activePointerId=null,e.pointerType=null,k(),L||d(e.target))},u={onKeyDown(n){m(n.nativeEvent)&&n.currentTarget.contains(n.target)&&(n.preventDefault(),n.stopPropagation(),e.isPressed||n.repeat||(e.target=n.currentTarget,e.isPressed=!0,t(n,"keyboard"),K(document,"keyup",s,!1)))},onKeyUp(t){m(t.nativeEvent)&&!t.repeat&&t.currentTarget.contains(t.target)&&r(h(e.target,t),"keyboard")},onClick(i){i&&!i.currentTarget.contains(i.target)||i&&0===i.button&&(i.stopPropagation(),g&&i.preventDefault(),e.ignoreClickAfterPress||e.ignoreEmulatedMouseEvents||"virtual"!==e.pointerType&&!f(i.nativeEvent)||(g||T||(0,o.Ao)(i.currentTarget),t(i,"virtual"),r(i,"virtual"),n(i,"virtual")),e.ignoreEmulatedMouseEvents=!1,e.ignoreClickAfterPress=!1)}},s=t=>{if(e.isPressed&&m(t)){t.preventDefault(),t.stopPropagation(),e.isPressed=!1;let r=t.target;n(h(e.target,t),"keyboard",e.target.contains(r)),k(),(e.target.contains(r)&&v(e.target)||"link"===e.target.getAttribute("role"))&&e.target.click()}};if("undefined"!=typeof PointerEvent){u.onPointerDown=n=>{var r;0===n.button&&n.currentTarget.contains(n.target)&&(0===(r=n.nativeEvent).width&&0===r.height||1===r.width&&1===r.height&&0===r.pressure&&0===r.detail?e.pointerType="virtual":(E(n.target)&&n.preventDefault(),e.pointerType=n.pointerType,n.stopPropagation(),e.isPressed||(e.isPressed=!0,e.isOverTarget=!0,e.activePointerId=n.pointerId,e.target=n.currentTarget,g||T||(0,o.Ao)(n.currentTarget),L||l(e.target),t(n,e.pointerType),K(document,"pointermove",s,!1),K(document,"pointerup",a,!1),K(document,"pointercancel",c,!1))))},u.onMouseDown=e=>{e.currentTarget.contains(e.target)&&0===e.button&&(E(e.target)&&e.preventDefault(),e.stopPropagation())},u.onPointerUp=t=>{t.currentTarget.contains(t.target)&&"virtual"!==e.pointerType&&0===t.button&&P(t,t.currentTarget)&&r(t,e.pointerType||t.pointerType)};let s=r=>{r.pointerId===e.activePointerId&&(P(r,e.target)?e.isOverTarget||(e.isOverTarget=!0,t(h(e.target,r),e.pointerType)):e.isOverTarget&&(e.isOverTarget=!1,n(h(e.target,r),e.pointerType,!1),O.current.shouldCancelOnPointerExit&&i(r)))},a=t=>{t.pointerId===e.activePointerId&&e.isPressed&&0===t.button&&(P(t,e.target)?n(h(e.target,t),e.pointerType):e.isOverTarget&&n(h(e.target,t),e.pointerType,!1),e.isPressed=!1,e.isOverTarget=!1,e.activePointerId=null,e.pointerType=null,k(),L||d(e.target))},c=e=>{i(e)};u.onDragStart=e=>{e.currentTarget.contains(e.target)&&i(e)}}else{u.onMouseDown=n=>{0===n.button&&n.currentTarget.contains(n.target)&&(E(n.target)&&n.preventDefault(),n.stopPropagation(),e.ignoreEmulatedMouseEvents||(e.isPressed=!0,e.isOverTarget=!0,e.target=n.currentTarget,e.pointerType=f(n.nativeEvent)?"virtual":"mouse",g||T||(0,o.Ao)(n.currentTarget),t(n,e.pointerType),K(document,"mouseup",s,!1)))},u.onMouseEnter=n=>{n.currentTarget.contains(n.target)&&(n.stopPropagation(),e.isPressed&&!e.ignoreEmulatedMouseEvents&&(e.isOverTarget=!0,t(n,e.pointerType)))},u.onMouseLeave=t=>{t.currentTarget.contains(t.target)&&(t.stopPropagation(),e.isPressed&&!e.ignoreEmulatedMouseEvents&&(e.isOverTarget=!1,n(t,e.pointerType,!1),O.current.shouldCancelOnPointerExit&&i(t)))},u.onMouseUp=t=>{t.currentTarget.contains(t.target)&&(e.ignoreEmulatedMouseEvents||0!==t.button||r(t,e.pointerType))};let s=t=>{0===t.button&&(e.isPressed=!1,k(),e.ignoreEmulatedMouseEvents?e.ignoreEmulatedMouseEvents=!1:(P(t,e.target)?n(h(e.target,t),e.pointerType):e.isOverTarget&&n(h(e.target,t),e.pointerType,!1),e.isOverTarget=!1))};u.onTouchStart=n=>{if(!n.currentTarget.contains(n.target))return;n.stopPropagation();let r=function(e){const{targetTouches:t}=e;if(t.length>0)return t[0];return null}(n.nativeEvent);r&&(e.activePointerId=r.identifier,e.ignoreEmulatedMouseEvents=!0,e.isOverTarget=!0,e.isPressed=!0,e.target=n.currentTarget,e.pointerType="touch",g||T||(0,o.Ao)(n.currentTarget),L||l(e.target),t(n,e.pointerType),K(window,"scroll",a,!0))},u.onTouchMove=r=>{if(!r.currentTarget.contains(r.target))return;if(r.stopPropagation(),!e.isPressed)return;let o=y(r.nativeEvent,e.activePointerId);o&&P(o,r.currentTarget)?e.isOverTarget||(e.isOverTarget=!0,t(r,e.pointerType)):e.isOverTarget&&(e.isOverTarget=!1,n(r,e.pointerType,!1),O.current.shouldCancelOnPointerExit&&i(r))},u.onTouchEnd=t=>{if(!t.currentTarget.contains(t.target))return;if(t.stopPropagation(),!e.isPressed)return;let o=y(t.nativeEvent,e.activePointerId);o&&P(o,t.currentTarget)?(r(t,e.pointerType),n(t,e.pointerType)):e.isOverTarget&&n(t,e.pointerType,!1),e.isPressed=!1,e.activePointerId=null,e.isOverTarget=!1,e.ignoreEmulatedMouseEvents=!0,L||d(e.target),k()},u.onTouchCancel=t=>{t.currentTarget.contains(t.target)&&(t.stopPropagation(),e.isPressed&&i(t))};let a=t=>{e.isPressed&&t.target.contains(e.target)&&i({currentTarget:e.target,shiftKey:!1,ctrlKey:!1,metaKey:!1,altKey:!1})};u.onDragStart=e=>{e.currentTarget.contains(e.target)&&i(e)}}return u}),[K,g,T,k,L]);return(0,r.useEffect)((()=>()=>{L||d(M.current.target)}),[L]),{isPressed:w||C,pressProps:(0,o.dG)(S,I)}}function v(e){return"A"===e.tagName&&e.hasAttribute("href")}function m(e){const{key:t,code:n,target:r}=e,o=r,{tagName:i,isContentEditable:u}=o,s=o.getAttribute("role");return!("Enter"!==t&&" "!==t&&"Spacebar"!==t&&"Space"!==n||"INPUT"===i||"TEXTAREA"===i||!0===u||v(o)&&("button"!==s||"Enter"===t)||"link"===s&&"Enter"!==t)}function y(e,t){const n=e.changedTouches;for(let e=0;e<n.length;e++){const r=n[e];if(r.identifier===t)return r}return null}function h(e,t){return{currentTarget:e,shiftKey:t.shiftKey,ctrlKey:t.ctrlKey,metaKey:t.metaKey,altKey:t.altKey}}function P(e,t){let n=t.getBoundingClientRect(),r=function(e){let t=e.width/2||e.radiusX||0,n=e.height/2||e.radiusY||0;return{top:e.clientY-n,right:e.clientX+t,bottom:e.clientY+n,left:e.clientX-t}}(e);return i=r,!((o=n).left>i.right||i.left>o.right||o.top>i.bottom||i.top>o.bottom);var o,i}function E(e){return!e.closest('[draggable="true"]')}p.displayName="PressResponderContext";function w(e){if(e.isDisabled)return{focusProps:{}};let t,n;return(e.onFocus||e.onFocusChange)&&(t=t=>{t.target===t.currentTarget&&(e.onFocus&&e.onFocus(t),e.onFocusChange&&e.onFocusChange(!0))}),(e.onBlur||e.onFocusChange)&&(n=t=>{t.target===t.currentTarget&&(e.onBlur&&e.onBlur(t),e.onFocusChange&&e.onFocusChange(!1))}),{focusProps:{onFocus:t,onBlur:n}}}let T=null,b=new Set,L=!1,S=!1,O=!1;function C(e,t){for(let n of b)n(e,t)}function D(e){S=!0,function(e){return!(e.metaKey||!(0,o.V5)()&&e.altKey||e.ctrlKey||"Control"===e.key||"Shift"===e.key||"Meta"===e.key)}(e)&&(T="keyboard",C("keyboard",e))}function M(e){T="pointer","mousedown"!==e.type&&"pointerdown"!==e.type||(S=!0,C("pointer",e))}function K(e){f(e)&&(S=!0,T="virtual")}function k(e){e.target!==window&&e.target!==document&&(S||O||(T="virtual",C("virtual",e)),S=!1,O=!1)}function I(){S=!1,O=!0}function A(){if("undefined"==typeof window||L)return;let e=HTMLElement.prototype.focus;HTMLElement.prototype.focus=function(){S=!0,e.apply(this,arguments)},document.addEventListener("keydown",D,!0),document.addEventListener("keyup",D,!0),document.addEventListener("click",K,!0),window.addEventListener("focus",k,!0),window.addEventListener("blur",I,!1),"undefined"!=typeof PointerEvent?(document.addEventListener("pointerdown",M,!0),document.addEventListener("pointermove",M,!0),document.addEventListener("pointerup",M,!0)):(document.addEventListener("mousedown",M,!0),document.addEventListener("mousemove",M,!0),document.addEventListener("mouseup",M,!0)),L=!0}function R(){return T}function F(e){let t=(0,r.useRef)({isFocusWithin:!1}).current;if(e.isDisabled)return{focusWithinProps:{}};return{focusWithinProps:{onFocus:n=>{t.isFocusWithin||(e.onFocusWithin&&e.onFocusWithin(n),e.onFocusWithinChange&&e.onFocusWithinChange(!0),t.isFocusWithin=!0)},onBlur:n=>{t.isFocusWithin&&!n.currentTarget.contains(n.relatedTarget)&&(e.onBlurWithin&&e.onBlurWithin(n),e.onFocusWithinChange&&e.onFocusWithinChange(!1),t.isFocusWithin=!1)}}}}"undefined"!=typeof document&&("loading"!==document.readyState?A():document.addEventListener("DOMContentLoaded",A));function x(e){let{ref:t,onInteractOutside:n,isDisabled:o,onInteractOutsideStart:i}=e,u=(0,r.useRef)({isPointerDown:!1,ignoreEmulatedMouseEvents:!1,onInteractOutside:n,onInteractOutsideStart:i}).current;u.onInteractOutside=n,u.onInteractOutsideStart=i,(0,r.useEffect)((()=>{if(o)return;let e=e=>{W(e,t)&&u.onInteractOutside&&(u.onInteractOutsideStart&&u.onInteractOutsideStart(e),u.isPointerDown=!0)};if("undefined"!=typeof PointerEvent){let n=e=>{u.isPointerDown&&u.onInteractOutside&&W(e,t)&&(u.isPointerDown=!1,u.onInteractOutside(e))};return document.addEventListener("pointerdown",e,!0),document.addEventListener("pointerup",n,!0),()=>{document.removeEventListener("pointerdown",e,!0),document.removeEventListener("pointerup",n,!0)}}{let n=e=>{u.ignoreEmulatedMouseEvents?u.ignoreEmulatedMouseEvents=!1:u.isPointerDown&&u.onInteractOutside&&W(e,t)&&(u.isPointerDown=!1,u.onInteractOutside(e))},r=e=>{u.ignoreEmulatedMouseEvents=!0,u.onInteractOutside&&u.isPointerDown&&W(e,t)&&(u.isPointerDown=!1,u.onInteractOutside(e))};return document.addEventListener("mousedown",e,!0),document.addEventListener("mouseup",n,!0),document.addEventListener("touchstart",e,!0),document.addEventListener("touchend",r,!0),()=>{document.removeEventListener("mousedown",e,!0),document.removeEventListener("mouseup",n,!0),document.removeEventListener("touchstart",e,!0),document.removeEventListener("touchend",r,!0)}}}),[t,u,o])}function W(e,t){if(e.button>0)return!1;if(e.target){const t=e.target.ownerDocument;if(!t||!t.documentElement.contains(e.target))return!1}return t.current&&!t.current.contains(e.target)}function z(e){if(!e)return;let t=!0;return n=>{let r=(0,u.Z)({},n,{preventDefault(){n.preventDefault()},isDefaultPrevented:()=>n.isDefaultPrevented(),stopPropagation(){console.error("stopPropagation is now the default behavior for events in React Spectrum. You can use continuePropagation() to revert this behavior.")},continuePropagation(){t=!1}});e(r),t&&n.stopPropagation()}}function N(e){return{keyboardProps:e.isDisabled?{}:{onKeyDown:z(e.onKeyDown),onKeyUp:z(e.onKeyUp)}}}},78831:function(e,t,n){n.d(t,{gP:function(){return l},Av:function(){return d}});var r=n(67294);function o(e,t,n,r){Object.defineProperty(e,t,{get:n,set:r,enumerable:!0,configurable:!0})}var i={};o(i,"SSRProvider",(()=>a)),o(i,"useSSRSafeId",(()=>l)),o(i,"useIsSSR",(()=>d));const u={prefix:String(Math.round(1e10*Math.random())),current:0},s=r.createContext(u);function a(e){let t=(0,r.useContext)(s),n=(0,r.useMemo)((()=>({prefix:t===u?"":`${t.prefix}-${++t.current}`,current:0})),[t]);return r.createElement(s.Provider,{value:n},e.children)}let c=Boolean("undefined"!=typeof window&&window.document&&window.document.createElement);function l(e){let t=(0,r.useContext)(s);return t!==u||c||console.warn("When server rendering, you must wrap your application in an <SSRProvider> to ensure consistent ids are generated between the client and server."),(0,r.useMemo)((()=>e||`react-aria${t.prefix}-${++t.current}`),[e])}function d(){let e=(0,r.useContext)(s)!==u,[t,n]=(0,r.useState)(e);return"undefined"!=typeof window&&e&&(0,r.useLayoutEffect)((()=>{n(!1)}),[]),t}},3366:function(e,t,n){n.d(t,{tS:function(){return E},zL:function(){return S},Ao:function(){return O},rP:function(){return j},gn:function(){return ne},V5:function(){return J},dG:function(){return w},QB:function(){return A},xi:function(){return x},Me:function(){return y},bt:function(){return v},mp:function(){return P},lE:function(){return B}});var r=n(67294),o=n(78831);function i(e){var t,n,r="";if("string"==typeof e||"number"==typeof e)r+=e;else if("object"==typeof e)if(Array.isArray(e))for(t=0;t<e.length;t++)e[t]&&(n=i(e[t]))&&(r&&(r+=" "),r+=n);else for(t in e)e[t]&&(r&&(r+=" "),r+=t);return r}function u(){for(var e,t,n=0,r="";n<arguments.length;)(e=arguments[n++])&&(t=i(e))&&(r&&(r+=" "),r+=t);return r}function s(e,t,n,r){Object.defineProperty(e,t,{get:n,set:r,enumerable:!0,configurable:!0})}function a(e,t,n){let[o,i]=(0,r.useState)(e||t),u=(0,r.useRef)(void 0!==e),s=u.current,a=void 0!==e,c=(0,r.useRef)(o);s!==a&&console.warn(`WARN: A component changed from ${s?"controlled":"uncontrolled"} to ${a?"controlled":"uncontrolled"}.`),u.current=a;let l=(0,r.useCallback)(((e,...t)=>{let r=(e,...t)=>{n&&(Object.is(c.current,e)||n(e,...t)),a||(c.current=e)};if("function"==typeof e){console.warn("We can not support a function callback. See Github Issues for details https://github.com/adobe/react-spectrum/issues/2320"),i(((n,...o)=>{let i=e(a?c.current:n,...o);return r(i,...t),a?n:i}))}else a||i(e),r(e,...t)}),[a,n]);return a?c.current=e:e=o,[e,l]}s({},"useControlledState",(()=>a));var c={};function l(e,t=-1/0,n=1/0){return Math.min(Math.max(e,t),n)}function d(e,t,n,r){let o=(e-(isNaN(t)?0:t))%r,i=2*Math.abs(o)>=r?e+Math.sign(o)*(r-Math.abs(o)):e-o;isNaN(t)?!isNaN(n)&&i>n&&(i=Math.floor(n/r)*r):i<t?i=t:!isNaN(n)&&i>n&&(i=t+Math.floor((n-t)/r)*r);let u=r.toString(),s=u.indexOf("."),a=s>=0?u.length-s:0;if(a>0){let e=Math.pow(10,a);i=Math.round(i*e)/e}return i}function f(e,t,n=10){const r=Math.pow(n,t);return Math.round(e*r)/r}function p(e,t,n,r){Object.defineProperty(e,t,{get:n,set:r,enumerable:!0,configurable:!0})}s(c,"clamp",(()=>l)),s(c,"snapValueToStep",(()=>d)),s(c,"toFixedNumber",(()=>f));var g={};p(g,"useId",(()=>y)),p(g,"mergeIds",(()=>h)),p(g,"useSlotId",(()=>P));p({},"useLayoutEffect",(()=>v));const v="undefined"!=typeof window?r.useLayoutEffect:()=>{};let m=new Map;function y(e){let t=(0,r.useRef)(!0);t.current=!0;let[n,i]=(0,r.useState)(e),u=(0,r.useRef)(null),s=(0,o.gP)(n),a=e=>{t.current?u.current=e:i(e)};return m.set(s,a),v((()=>{t.current=!1}),[a]),v((()=>{let e=s;return()=>{m.delete(e)}}),[s]),(0,r.useEffect)((()=>{let e=u.current;e&&(i(e),u.current=null)}),[i,a]),s}function h(e,t){if(e===t)return e;let n=m.get(e);if(n)return n(t),t;let r=m.get(t);return r?(r(e),e):t}function P(e=[]){let t=y(),[n,o]=ae(t),i=(0,r.useCallback)((()=>{o((function*(){yield t,yield document.getElementById(t)?t:null}))}),[t,o]);return v(i,[t,i,...e]),n}function E(...e){return(...t)=>{for(let n of e)"function"==typeof n&&n(...t)}}p({},"chain",(()=>E));function w(...e){let t={...e[0]};for(let n=1;n<e.length;n++){let r=e[n];for(let e in r){let n=t[e],o=r[e];"function"==typeof n&&"function"==typeof o&&"o"===e[0]&&"n"===e[1]&&e.charCodeAt(2)>=65&&e.charCodeAt(2)<=90?t[e]=E(n,o):"className"!==e&&"UNSAFE_className"!==e||"string"!=typeof n||"string"!=typeof o?"id"===e&&n&&o?t.id=h(n,o):t[e]=void 0!==o?o:n:t[e]=u(n,o)}}return t}p({},"mergeProps",(()=>w));p({},"filterDOMProps",(()=>S));const T=new Set(["id"]),b=new Set(["aria-label","aria-labelledby","aria-describedby","aria-details"]),L=/^(data-.*)$/;function S(e,t={}){let{labelable:n,propNames:r}=t,o={};for(const t in e)Object.prototype.hasOwnProperty.call(e,t)&&(T.has(t)||n&&b.has(t)||(null==r?void 0:r.has(t))||L.test(t))&&(o[t]=e[t]);return o}function O(e){if(function(){if(null==C){C=!1;try{document.createElement("div").focus({get preventScroll(){return C=!0,!0}})}catch(e){}}return C}())e.focus({preventScroll:!0});else{let t=function(e){var t=e.parentNode,n=[],r=document.scrollingElement||document.documentElement;for(;t instanceof HTMLElement&&t!==r;)(t.offsetHeight<t.scrollHeight||t.offsetWidth<t.scrollWidth)&&n.push({element:t,scrollTop:t.scrollTop,scrollLeft:t.scrollLeft}),t=t.parentNode;r instanceof HTMLElement&&n.push({element:r,scrollTop:r.scrollTop,scrollLeft:r.scrollLeft});return n}(e);e.focus(),function(e){for(let{element:t,scrollTop:n,scrollLeft:r}of e)t.scrollTop=n,t.scrollLeft=r}(t)}}p({},"focusWithoutScrolling",(()=>O));let C=null;function D(e,t,n="horizontal"){let r=e.getBoundingClientRect();return t?"horizontal"===n?r.right:r.bottom:"horizontal"===n?r.left:r.top}p({},"getOffset",(()=>D));var M={};p(M,"clamp",(()=>l)),p(M,"snapValueToStep",(()=>d));p({},"runAfterTransition",(()=>A));let K=new Map,k=new Set;function I(){if("undefined"==typeof window)return;let e=t=>{let n=K.get(t.target);if(n&&(n.delete(t.propertyName),0===n.size&&(t.target.removeEventListener("transitioncancel",e),K.delete(t.target)),0===K.size)){for(let e of k)e();k.clear()}};document.body.addEventListener("transitionrun",(t=>{let n=K.get(t.target);n||(n=new Set,K.set(t.target,n),t.target.addEventListener("transitioncancel",e)),n.add(t.propertyName)})),document.body.addEventListener("transitionend",e)}function A(e){requestAnimationFrame((()=>{0===K.size?e():k.add(e)}))}"undefined"!=typeof document&&("loading"!==document.readyState?I():document.addEventListener("DOMContentLoaded",I));p({},"useDrag1D",(()=>F));const R=[];function F(e){console.warn("useDrag1D is deprecated, please use `useMove` instead https://react-spectrum.adobe.com/react-aria/useMove.html");let{containerRef:t,reverse:n,orientation:o,onHover:i,onDrag:u,onPositionChange:s,onIncrement:a,onDecrement:c,onIncrementToMax:l,onDecrementToMin:d,onCollapseToggle:f}=e,p=e=>{let r=D(t.current,n,o),i=(e=>"horizontal"===o?e.clientX:e.clientY)(e);return n?r-i:i-r},g=(0,r.useRef)(!1),v=(0,r.useRef)(0),m=(0,r.useRef)({onPositionChange:s,onDrag:u});m.current.onDrag=u,m.current.onPositionChange=s;let y=e=>{e.preventDefault();let t=p(e);g.current||(g.current=!0,m.current.onDrag&&m.current.onDrag(!0),m.current.onPositionChange&&m.current.onPositionChange(t)),v.current!==t&&(v.current=t,s&&s(t))},h=e=>{const t=e.target;g.current=!1;let n=p(e);m.current.onDrag&&m.current.onDrag(!1),m.current.onPositionChange&&m.current.onPositionChange(n),R.splice(R.indexOf(t),1),window.removeEventListener("mouseup",h,!1),window.removeEventListener("mousemove",y,!1)};return{onMouseDown:e=>{const t=e.currentTarget;R.some((e=>t.contains(e)))||(R.push(t),window.addEventListener("mousemove",y,!1),window.addEventListener("mouseup",h,!1))},onMouseEnter:()=>{i&&i(!0)},onMouseOut:()=>{i&&i(!1)},onKeyDown:e=>{switch(e.key){case"Left":case"ArrowLeft":"horizontal"===o&&(e.preventDefault(),c&&!n?c():a&&n&&a());break;case"Up":case"ArrowUp":"vertical"===o&&(e.preventDefault(),c&&!n?c():a&&n&&a());break;case"Right":case"ArrowRight":"horizontal"===o&&(e.preventDefault(),a&&!n?a():c&&n&&c());break;case"Down":case"ArrowDown":"vertical"===o&&(e.preventDefault(),a&&!n?a():c&&n&&c());break;case"Home":e.preventDefault(),d&&d();break;case"End":e.preventDefault(),l&&l();break;case"Enter":e.preventDefault(),f&&f()}}}}function x(){let e=(0,r.useRef)(new Map),t=(0,r.useCallback)(((t,n,r,o)=>{let i=(null==o?void 0:o.once)?(...t)=>{e.current.delete(r),r(...t)}:r;e.current.set(r,{type:n,eventTarget:t,fn:i,options:o}),t.addEventListener(n,r,o)}),[]),n=(0,r.useCallback)(((t,n,r,o)=>{var i;let u=(null===(i=e.current.get(r))||void 0===i?void 0:i.fn)||r;t.removeEventListener(n,u,o),e.current.delete(r)}),[]),o=(0,r.useCallback)((()=>{e.current.forEach(((e,t)=>{n(e.eventTarget,e.type,t,e.options)}))}),[n]);return(0,r.useEffect)((()=>o),[o]),{addGlobalListener:t,removeGlobalListener:n,removeAllGlobalListeners:o}}p({},"useGlobalListeners",(()=>x));function W(e,t){let{id:n,"aria-label":r,"aria-labelledby":o}=e;if(n=y(n),o&&r){let e=new Set([...o.trim().split(/\s+/),n]);o=[...e].join(" ")}else o&&(o=o.trim().split(/\s+/).join(" "));return r||o||!t||(r=t),{id:n,"aria-label":r,"aria-labelledby":o}}p({},"useLabels",(()=>W));function z(e){const t=(0,r.useRef)();return v((()=>{e&&("function"==typeof e?e(t.current):e.current=t.current)}),[e]),t}p({},"useObjectRef",(()=>z));function N(e,t){const n=(0,r.useRef)(!0);(0,r.useEffect)((()=>{n.current?n.current=!1:e()}),t)}p({},"useUpdateEffect",(()=>N));function U(e){const{ref:t,onResize:n}=e;(0,r.useEffect)((()=>{let e=null==t?void 0:t.current;if(e){if(void 0===window.ResizeObserver)return window.addEventListener("resize",n,!1),()=>{window.removeEventListener("resize",n,!1)};{const t=new window.ResizeObserver((e=>{e.length&&n()}));return t.observe(e),()=>{e&&t.unobserve(e)}}}}),[n,t])}p({},"useResizeObserver",(()=>U));function B(e,t){v((()=>{if(e&&e.ref&&t)return e.ref.current=t.current,()=>{e.ref.current=null}}),[e,t])}p({},"useSyncRef",(()=>B));function j(e){for(;e&&!H(e);)e=e.parentElement;return e||document.scrollingElement||document.documentElement}function H(e){let t=window.getComputedStyle(e);return/(auto|scroll)/.test(t.overflow+t.overflowX+t.overflowY)}p({},"getScrollParent",(()=>j));p({},"useViewportSize",(()=>V));let G="undefined"!=typeof window&&window.visualViewport;function V(){let[e,t]=(0,r.useState)((()=>_()));return(0,r.useEffect)((()=>{let e=()=>{t((e=>{let t=_();return t.width===e.width&&t.height===e.height?e:t}))};return G?G.addEventListener("resize",e):window.addEventListener("resize",e),()=>{G?G.removeEventListener("resize",e):window.removeEventListener("resize",e)}}),[]),e}function _(){return{width:(null==G?void 0:G.width)||window.innerWidth,height:(null==G?void 0:G.height)||window.innerHeight}}p({},"useDescription",(()=>Y));let $=0;const X=new Map;function Y(e){let[t,n]=(0,r.useState)(null);return v((()=>{if(!e)return;let t=X.get(e);if(t)n(t.element.id);else{let r="react-aria-description-"+$++;n(r);let o=document.createElement("div");o.id=r,o.style.display="none",o.textContent=e,document.body.appendChild(o),t={refCount:0,element:o},X.set(e,t)}return t.refCount++,()=>{0==--t.refCount&&(t.element.remove(),X.delete(e))}}),[e]),{"aria-describedby":e?t:void 0}}var Z={};function Q(e){return"undefined"!=typeof window&&null!=window.navigator&&e.test(window.navigator.userAgent)}function q(e){return"undefined"!=typeof window&&null!=window.navigator&&e.test(window.navigator.platform)}function J(){return q(/^Mac/)}function ee(){return q(/^iPhone/)}function te(){return q(/^iPad/)||J()&&navigator.maxTouchPoints>1}function ne(){return ee()||te()}function re(){return J()||ne()}function oe(){return Q(/AppleWebKit/)&&!ie()}function ie(){return Q(/Chrome/)}function ue(){return Q(/Android/)}p(Z,"isMac",(()=>J)),p(Z,"isIPhone",(()=>ee)),p(Z,"isIPad",(()=>te)),p(Z,"isIOS",(()=>ne)),p(Z,"isAppleDevice",(()=>re)),p(Z,"isWebKit",(()=>oe)),p(Z,"isChrome",(()=>ie)),p(Z,"isAndroid",(()=>ue));function se(e,t,n,o){let i=(0,r.useRef)(n);i.current=n;let u=null==n;(0,r.useEffect)((()=>{if(u)return;let n=e.current,r=e=>i.current.call(this,e);return n.addEventListener(t,r,o),()=>{n.removeEventListener(t,r,o)}}),[e,t,o,u])}p({},"useEvent",(()=>se));function ae(e){let[t,n]=(0,r.useState)(e),o=(0,r.useRef)(t),i=(0,r.useRef)(null);o.current=t;let u=(0,r.useRef)(null);u.current=()=>{let e=i.current.next();e.done?i.current=null:t===e.value?u.current():n(e.value)},v((()=>{i.current&&u.current()}));let s=(0,r.useCallback)((e=>{i.current=e(o.current),u.current()}),[i,u]);return[t,s]}p({},"useValueEffect",(()=>ae));function ce(e,t){let n=le(e,t,"left"),r=le(e,t,"top"),o=t.offsetWidth,i=t.offsetHeight,u=e.scrollLeft,s=e.scrollTop,a=u+e.offsetWidth,c=s+e.offsetHeight;n<=u?u=n:n+o>a&&(u+=n+o-a),r<=s?s=r:r+i>c&&(s+=r+i-c),e.scrollLeft=u,e.scrollTop=s}function le(e,t,n){const r="left"===n?"offsetLeft":"offsetTop";let o=0;for(;t.offsetParent&&(o+=t[r],t.offsetParent!==e);){if(t.offsetParent.contains(e)){o-=e[r];break}t=t.offsetParent}return o}p({},"scrollIntoView",(()=>ce))},87462:function(e,t,n){function r(){return r=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e},r.apply(this,arguments)}n.d(t,{Z:function(){return r}})},63366:function(e,t,n){function r(e,t){if(null==e)return{};var n,r,o={},i=Object.keys(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||(o[n]=e[n]);return o}n.d(t,{Z:function(){return r}})}}]);
//# sourceMappingURL=354-414ced3e36898b5d8728.js.map