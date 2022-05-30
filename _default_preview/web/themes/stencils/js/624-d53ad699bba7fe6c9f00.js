"use strict";(self.webpackChunkPlug_and_Play_Template=self.webpackChunkPlug_and_Play_Template||[]).push([[624],{37059:function(e,t,s){s.d(t,{Z:function(){return c}});s(33948);var a=s(67294);function n(){return n=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var s=arguments[t];for(var a in s)Object.prototype.hasOwnProperty.call(s,a)&&(e[a]=s[a])}return e},n.apply(this,arguments)}function l(e){let{children:t,toggleIsCollapsed:s,isCollapsed:n,iscollapsible:l,id:c}=e;return l?a.createElement("button",{className:"collapsible-card__header",type:"button",onClick:s,"aria-expanded":!n,"aria-controls":"content-".concat(c)},t):a.createElement("div",{className:"collapsible-card__header"},t)}function c(e){const{wrapperClasses:t,contentClasses:s,children:c,id:r,headingIcon:o,iscollapsible:i,isInitialCollapsed:m,isScrollable:u,subTitle:d,title:p,..._}=e;let E="";r&&(E="ComponentCard-".concat(r));let h=m||!1;E&&(h="collapsed"===localStorage.getItem(E));const[y,v]=(0,a.useState)(h),g=["collapsible-card","no-wysiwyg",t].join(" "),f=["collapsible-card__contents",s,u&&"collapsible-card--scrollable"].join(" "),N=["svg-icon",!1===y&&"collapsible-card__collapsed"].join(" "),b=(0,a.useCallback)((()=>{v(!y),E&&localStorage.setItem(E,y?"":"collapsed")}),[E,y]);return a.createElement("div",n({className:g,id:r},_),a.createElement(l,{iscollapsible:i,toggleIsCollapsed:b,isCollapsed:y,id:r},a.createElement("h2",{className:"collapsible-card__header-text"},p),(d||i||o)&&a.createElement("div",{className:"collapsible-card__header-right"},d&&a.createElement("h3",{className:"collapsible-card__header-text collapsible-card__header-text--sub-title"},d),i&&a.createElement("svg",{className:"".concat(N," collapsible-card__more-menu-icon")},a.createElement("title",null,y?"Expand panel":"Collapse panel"),a.createElement("use",{href:"#chevron"})),o)),(!0!==i||!0===i&&!1===y)&&a.createElement("div",{className:f,id:"content-".concat(r),role:"region",tabIndex:-1},c))}},12624:function(e,t,s){s.r(t),s.d(t,{default:function(){return _}});var a=s(67294),n=s(45697),l=s.n(n),c=s(63774),r=s(37059);s(33948);function o(e){let{collapsedTitle:t,expandedTitle:s,isOpen:n,shouldAnimate:l,children:c,displayChevron:r,additionalButtonClasses:o,additionalContentClasses:i}=e;const[m,u]=(0,a.useState)(!n),[d,p]=(0,a.useState)(!1);return a.createElement(a.Fragment,null,a.createElement("button",{type:"button",onClick:function(){l?p(!0):u(!m)},"aria-expanded":!m,className:"react-collapse__button".concat(o?" ".concat(o):"","\n                ").concat(m?"":"react-collapse__button--open")},r&&a.createElement("span",{className:"react-collapse__chevron ".concat(m?"react-collapse__chevron--up":"react-collapse__chevron--down")},a.createElement("svg",{className:"svg-icon"},a.createElement("use",{xlinkHref:"#chevron"}),a.createElement("title",null,"Chevron"))),m?t:s||t),a.createElement("div",{className:function(){const e=["react-collapse__content",i];return m&&d&&e.push("react-collapse__content--expanding"),!m&&d&&e.push("react-collapse__content--collapsing"),m||e.push("react-collapse__content--open"),e.join(" ")}(),onTransitionEnd:void(d&&(p(!1),u(!m)))},c))}o.propTypes={collapsedTitle:l().string,expandedTitle:l().string,isOpen:l().bool,shouldAnimate:l().bool,children:l().node},o.defaultProps={collapsedTitle:"Title",expandedTitle:"Title",isOpen:!0,shouldAnimate:!1,children:"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Unde repudiandae distinctio voluptatum laborum quod, quisquam corrupti pariatur possimus totam adipisci est soluta, aut, quos magni. Aspernatur velit perferendis et incidunt."};var i=function(e,t){if("number"!=typeof t||!Number.isInteger(t))throw new Error("The point must be an integer.");if(!Array.isArray(e))throw new Error("The array must be an array.");return 0===e.length||t>=e.length?[e,[]]:[e.slice(0,t),e.slice(t)]};var m=function(e){if(void 0===e||"number"!=typeof e)throw new Error("Please ensure that bytes is passed as a number");if(0===e)return"0 Bytes";const t=parseInt(Math.floor(Math.log(e)/Math.log(1024)),10);return"".concat(Math.round(e/1024**t,2)," ").concat(["Bytes","KB","MB","GB","TB"][t])};function u(e){let{name:t,due:s}=e;const n=new Date(s);return a.createElement("div",{className:"my-courses__assessment-item"},a.createElement("div",{className:"my-courses__assessment-name"},t),a.createElement("div",{className:"my-courses__assessment-due"},n.toLocaleDateString("en-US",{month:"short",day:"numeric"})))}function d(e){let{name:t,date:s,link:n,fileSize:l}=e;const c=new Date(s);return a.createElement("div",{className:"my-courses__update-item"},a.createElement("div",{className:"my-courses__update-icon"},a.createElement("svg",{className:"svg-icon"},a.createElement("use",{href:"#attachment"}),a.createElement("title",null,"Attachment icon"))),a.createElement("div",{className:"my-courses__update-name"},t," (",m(l),")"," ",a.createElement("a",{className:"my-courses__update-link",href:n},"Download")),a.createElement("div",{className:"my-courses__update-date"},c.toLocaleDateString("en-US",{month:"short",day:"numeric"})))}function p(e){let{assessments:t,updates:s}=e;const[n,l]=i(t,4),[c,r]=i(s,4);return a.createElement(a.Fragment,null,a.createElement("div",{className:"my-courses__assessments"},a.createElement("div",{className:"my-courses__assessments-title-wrapper"},a.createElement("div",{className:"my-courses__assessments-icon"},a.createElement("svg",{className:"svg-icon"},a.createElement("use",{href:"#edit"}),a.createElement("title",null,"Edit icon"))),a.createElement("div",{className:"my-courses__assessments-title"},"Assignments & Assessments"),a.createElement("div",{className:"my-courses__assessments-column-heading"},"Due Date")),n.map((e=>{const{id:t,name:s,due:n}=e;return a.createElement(u,{key:t,name:s,due:n})})),l.length>0&&a.createElement(o,{displayChevron:!0,title:"Show more",isOpen:!1,additionalButtonClasses:"my-courses__show-more-button",additionalContentClasses:"my-courses__show-more-content"},l.map((e=>{const{id:t,name:s,due:n}=e;return a.createElement(u,{key:t,name:s,due:n})})))),a.createElement("div",{className:"my-courses__updates"},a.createElement("div",{className:"my-courses__updates-title-wrapper"},a.createElement("div",{className:"my-courses__updates-title"},"Course updates"),a.createElement("div",{className:"my-courses__updates-column-heading"},"Date")),c.map((e=>{const{id:t,name:s,date:n,link:l,fileSize:c}=e;return a.createElement(d,{key:t,name:s,date:n,link:l,fileSize:c})})),r.length>0&&a.createElement(o,{displayChevron:!0,collapsedTitle:"Show more",expandedTitle:"Show less",isOpen:!1,additionalButtonClasses:"my-courses__show-more-button",additionalContentClasses:"my-courses__show-more-content"},r.map((e=>{const{id:t,name:s,date:n,link:l,fileSize:c}=e;return a.createElement(d,{key:t,name:s,date:n,link:l,fileSize:c})})))),a.createElement("div",{className:"my-courses__footer"},a.createElement("a",{className:"my-courses__footer-link",href:"#"},"Download syllabus"),a.createElement("a",{className:"my-courses__footer-button--light",href:"#"},a.createElement("svg",{className:"svg-icon"},a.createElement("use",{href:"#download"}),a.createElement("title",null,"Download icon")),"Syllabus"),a.createElement("a",{className:"my-courses__footer-button",href:"#"},a.createElement("svg",{className:"svg-icon"},a.createElement("use",{href:"#external"}),a.createElement("title",null,"External icon")),"Canvas")))}function _(e){let{title:t}=e;const{courses:s,getCourses:n}=(0,a.useContext)(c.Z);return(0,a.useEffect)((()=>{n()}),[]),0===s.length?a.createElement("div",{className:"my-courses"},a.createElement("div",{className:"my-courses__heading"},a.createElement("div",{className:"my-courses__title"},t)),a.createElement("div",{className:"my-courses__empty-container"},a.createElement("div",{className:"my-courses__empty-content"},a.createElement("div",{className:"my-courses__svg-wrapper"},a.createElement("svg",{className:"svg-icon"},a.createElement("use",{href:"#no-courses"}),a.createElement("title",null,"Empty box icon"))),a.createElement("div",{className:"my-courses__empty-text"},a.createElement("b",null,"No courses added"),a.createElement("br",null),"Contact your administrator")))):a.createElement("div",{className:"my-courses"},a.createElement("div",{className:"my-courses__heading"},a.createElement("div",{className:"my-courses__title"},"My courses")),a.createElement("div",{className:"my-courses__container"},s&&s.map(((e,t)=>{const{code:s,name:n,assessments:l,updates:c}=e;return a.createElement(r.Z,{iscollapsible:!0,isInitialCollapsed:0!==t,key:e.id,title:"".concat(s," | ").concat(n),wrapperClasses:"my-courses__card",contentClasses:"my-courses__content"},a.createElement(p,{assessments:l,updates:c}))}))))}u.propTypes={name:l().string.isRequired,due:l().instanceOf(Date).isRequired},d.propTypes={name:l().string.isRequired,date:l().instanceOf(Date).isRequired,link:l().string.isRequired},_.propTypes={title:l().string},_.defaultProps={title:"My Courses"}}}]);
//# sourceMappingURL=624-d53ad699bba7fe6c9f00.js.map