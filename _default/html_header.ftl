<#ftl encoding="utf-8" output_format="HTML" />
<#-- Outputs all the css and related libraries used for the implementation -->

<#-- Template specific code. Avoid changing these files if possible -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,400&display=swap" rel="stylesheet">

<link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
<link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.0/css/all.css">
<link rel="stylesheet" href="/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer-typeahead.css">

<#-- 
    Implementation specific style changes. It is recommended that changes to the 
    presentation of this implementation should be made here.
-->
<link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/stencils.css">

<#-- Showcase related presentation -->
<#if ((question.getCurrentProfileConfig().get("stencils.showcase"))!"FALSE")?upper_case == "TRUE">
    <link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/showcase.css">
</#if>

<#-- 
    Implementation specific style changes. It is recommended that changes to the 
    presentation of this implementation should be made here.
-->
<link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer.css">


