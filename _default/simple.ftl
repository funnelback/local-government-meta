<#ftl encoding="utf-8" output_format="HTML" />

<#-- Core Funnelback imports -->
<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#-- 
  Global Stencils imports
  The namespace will be available in all templates which are imported 
-->
<#import "project.ftl" as project />
<#import "base.ftl" as base />
<#import "tabs.ftl" as tabs />
<#import "facets.ftl" as facets />
<#import "history_cart.ftl" as history_cart />

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
<#import "road_works.ftl" as road_works />
<#import "planning_applications.ftl" as planning_applications />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="robots" content="nofollow,noindex">
  
  <link rel="stylesheet" href="/stencils/resources/he/v15.12/css/he.css">

  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.0/css/all.css">

  <@client_includes.HTMLHeader />

  <title><@s.AfterSearchOnly>${question.query!}<@s.IfDefCGI name="query">,&nbsp;</@s.IfDefCGI></@s.AfterSearchOnly><@s.cfg>service_name</@s.cfg></title>

</head>
<body>

  <@client_includes.ContentHeader />

  

  <main class="funnelback">
    <h1 class="sr-only">Search</h1>

    <@project.SearchForm />
    <@s.AfterSearchOnly>
      <@project.Tabs />
      
      <div class="d-flex">
        <@project.SideNavigation />
        <@project.Results />

        <section>
          <div class="container-fluid">
            <@history_cart.Cart />
          </div>
        </section>

        <@history_cart.SearchHistory />
      </div>
      
    </@s.AfterSearchOnly>
  </main>

  <@client_includes.ContentFooter />
  <@project.SignupModal />

  <script src="/stencils/resources/thirdparty/jquery/v3.2.1/jquery-3.2.1.min.js"></script>
  <script src="/stencils/resources/thirdparty/popper/v1.12.3/umd/popper.min.js"></script>
  <script src="/stencils/resources/thirdparty/bootstrap/v4.0.0/js/bootstrap.min.js"></script>

  <script src="/stencils/resources/autocompletion/js/typeahead.bundle-0.11.1.min.js"></script>
  <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/handlebars-4.0.12/handlebars.min.js"></script>
  <script src="/s/resources/${question.collection.id}/${question.profile}/js/typeahead.fb-2.6.js"></script>
  <script src="/s/resources/${question.collection.id}/${question.profile}/js/base.js"></script> 

  <@events.AutoCompleteTemplate />
  <@people.AutoCompleteTemplate />

  <@events.CartTemplate />

  <script>
    jQuery(document).ready( function() {
      setupDeferredImages();
      setupFacetLessMoreButtons(${question.collection.configuration.value("stencils.faceted_navigation.max_displayed_categories", "8")}, '.fb-sidebar__nav');
      <@project.AutoComplete />
    });
  </script>



  <#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
    <script type="text/javascript" src="${GlobalResourcesPrefix}thirdparty/es6-promise-4.2.5/es6-promise.auto.min.js"></script>
    <script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-cart-0.1.js"></script>
    <script type="text/javascript" src="${GlobalResourcesPrefix}js/funnelback.session-history-0.1.min.js"></script>
    <#--  <@history_cart.Configuration />  -->

  <script type="text/javascript">
    window.addEventListener('DOMContentLoaded', function() {

      new Funnelback.SessionCart({
        collection: '${question.collection.id}',
        iconPrefix: '',
        cartCount: {
          template: '{{>icon-block}} {{>label-block}} ({{count}})',
          icon: 'fas fa-star',
          label: 'Shortlist',
          isLabel: true
        },
        cart: {
          icon: 'fas fa-star',
          label: ' Shortlist ',
          backIcon: 'fas fa-arrow-left',
          backLabel: 'Back to results',
          clearIcon: 'fas fa-times',
          clearClasses: "btn btn-xs btn-light",                    
          emptyMessage: '<span id="flb-cart-empty-message">No items in your shortlist</span>',
          pageSelector: ['#search-results-content', '#search-history', '#fb-session__side-navigation']
        },
        item: {
          icon: 'fas fa-star',          
          template: document.getElementById('cart-template-membership-association-events-web').text
        },
        resultItemTrigger: {
          selector: '.enable-cart-on-result',
          labelAdd: '',
          iconAdd: 'far fa-star',
          labelDelete: '',
          iconDelete: 'fas fa-star',
          isLabel: false,
          template: '<span class="text-info float-right">{{>icon-block}} {{>label-block}}</span>',
          position: 'afterbegin'
        },
        cartItemTrigger: {
          selector: ".fb-cart__remove",
          iconDelete: "fas",
          template: '{{>icon-block}} {{>label-block}}',
          position: 'afterbegin',
          isLabel: true,
          labelDelete: "REMOVE FROM SHORTLIST"
        }        
      });
      
      new Funnelback.SessionHistory({
        collection: '${question.collection.id}',
        currentSearchHistorySelectors: ['.session-history-search-results'],
        currentClickHistorySelectors: ['.session-history-click-results'],
        pageSelector: ['#search-results-content', '#search-cart','#fb-session__side-navigation']
      });
    });

    <#-- ToDO - Figure out how to attach handlebar helpers 
    window.Funnelback.SessionCart.prototype.Handlebars.registerHelper('equal', function(lvalue, rvalue, options) {
      if (arguments.length < 3)
        throw new Error("Handlebars Helper equal needs 2 parameters");
      if( lvalue!=rvalue ) {
        return options.inverse(this);
      } else {
        return options.fn(this);
      }
    });
    -->    
  </script>

  </#if>

</body>
</html>
<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
