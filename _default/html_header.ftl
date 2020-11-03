<#ftl encoding="utf-8" output_format="HTML" />
<#-- Outputs all the css and related libraries used for the implementation -->

<#-- Template specific code. Avoid changing these files if possible -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800&display=swap" rel="stylesheet">
<link href="https://unpkg.com/normalize.css@8.0.1/normalize.css" rel="stylesheet">
<link href="/s/resources/${question.collection.id}/${question.profile}/css/main.css" rel="stylesheet">


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.0/css/all.css">
<link rel="stylesheet" href="/s/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer-typeahead.css">

<#-- 
    Implementation specific style changes. It is recommended that changes to the 
    presentation of this implementation should be made here.
-->
<link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/customer.css">

<#-- Showcase related presentation - Please remove as part of the project -->
<link rel="stylesheet" href="${ContextPath}/resources/${(question.collection.id)!}/${(question.profile)!}/css/showcase.css">

