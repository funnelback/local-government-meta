<#ftl encoding="utf-8" output_format="HTML" />
<#--
    This file is responsible for determining the overall structure
    of the search implementations. It contains things such as:

    - The HTML for the overall structure such as the header, footer 
        and main content.
    - The references to the client's header and footer
    - Third party libraries
    - References to javascript templates for sessions and concierge
-->

<#-- Core Funnelback imports -->
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#-- 
	Global Stencils imports
	The namespace will be available in all templates which are imported 
-->
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "curator.ftl" as curator />
<#import "tabs.ftl" as tabs />
<#import "facets.ftl" as facets />
<#import "contextual_navigation.ftl" as contextual_navigation />
<#import "history_cart.ftl" as history_cart />
<#import "auto_complete.ftl" as auto_complete />
<#import "curator.ftl" as curator />
<#import "extra_search.ftl" as extra_search />
<#import "results.ftl" as results />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />

<#-- Specific result styling imports
	These imports are required for the automatic template selection to work
	The various namespaces (e.g. 'video', 'facebook') need to be on the main scope 
-->
<#import "events.ftl" as events />
<#import "jobs.ftl" as jobs />
<#import "services.ftl" as services />
<#import "journals.ftl" as journals />
<#import "cemetery.ftl" as cemetery />
<#import "roadworks.ftl" as roadworks />
<#import "planning_applications.ftl" as planning_applications />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="robots" content="nofollow,noindex">

	<@client_includes.HTMLHeader />

	<title><@s.AfterSearchOnly>${question.query!}<@s.IfDefCGI name="query">,&nbsp;</@s.IfDefCGI></@s.AfterSearchOnly><@s.cfg>service_name</@s.cfg></title>

</head>
<body>
	<@client_includes.ContentHeader />

	<div class="fb-container">
		<main class="main <@s.InitialFormOnly>initial-search-form</@s.InitialFormOnly>" role="main">
			<@project.SearchForm />
			<@s.AfterSearchOnly>
				<@project.Tabs />
				<section class="content-wrapper content-wrapper--col">
					<@project.Facets />
					<@project.Results />
				</section>
			</@s.AfterSearchOnly>
		</main>
	</div>    

	<@client_includes.ContentFooter />

	<#-- 
		Libraries required by the design developed by the Vertical Products cutup team. 
		Avoid changing these if possible
	-->
	<script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/vendors.js"></script>
	<script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/main.js"></script>
	<script type="text/javascript" src="/s/resources/${question.collection.id}/${question.profile}/js/runtime.js"></script>


	<script src="/stencils/resources/thirdparty/popper/v1.12.3/umd/popper.min.js"></script>
	<script src="/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
	
	<script src="/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
	<script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/handlebars-4.0.12/handlebars.min.js"></script>
	<script src="/s/resources/${question.collection.id}/${question.profile}/js/base.js"></script> 
	<script src="${GlobalResourcesPrefix}js/funnelback.autocompletion-2.6.0.js"></script>


	<#-- Output the auto complete templates for concierge -->

	<@cemetery.AutoCompleteTemplate />
	<@planning_applications.AutoCompleteTemplate />
	<@results.CartTemplate />
	
	<script>
		jQuery(document).ready( function() {
			setupDeferredImages();
			setupFacetLessMoreButtons(${question.collection.configuration.value("stencils.faceted_navigation.max_displayed_categories", "8")}, '.fb-sidebar__nav');
			<@auto_complete.Configuration />
		});
	</script>


	<#-- Enable session functonality which includes cart and history -->
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
		<script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/es6-promise-4.2.5/es6-promise.auto.min.js"></script>
		<script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-cart-0.1.js"></script>
		<script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-history-0.1.js"></script>
		<@history_cart.Configuration />
	</#if>

</body>
</html>
