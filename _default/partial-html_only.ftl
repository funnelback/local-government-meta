<#ftl encoding="utf-8" output_format="HTML" />

<#-- 
  This template outputs only the HTML component of the Higher Education Vertical Product 
  (excluding the header and footer). This is required in the scenario where the target CMS 
  want to be responsible for displaying the header and footer and serve up all the css
  and javascript. 

  e.g. Squiz Matrix Neo Templates: https://marketplace-dev.squiz.systems/hugo/fb-search-esi 
-->


<#import "/web/templates/modernui/funnelback_classic.ftl" as s/>
<#import "/web/templates/modernui/funnelback.ftl" as fb />

<#import "/share/stencils/libraries/base/client_includes.ftl" as client_includes />
<#import "history_cart.ftl" as history_cart />

<#-- These imports are required for the automatic template selection to work
  The various namespaces (e.g. 'video', 'facebook') need to be on the main scope -->
<#import "project.ftl" as project />
<#import "courses.ftl" as courses />
<#import "people.ftl" as people />
<#import "video.ftl" as video />
<#import "facebook.ftl" as facebook />
<#import "events.ftl" as events />
<#import "instagram.ftl" as instagram />

  

  <div class="funnelback">
    <h1 class="sr-only">Search</h1>


      <@s.AfterSearchOnly>
        <@project.Tabs />
        <@project.Results />
      </@s.AfterSearchOnly>
  </div>


  <@courses.AutoCompleteTemplate />
  <@people.AutoCompleteTemplate />

  

  

<#-- vim: set expandtab ts=2 sw=2 sts=2 :-->
