<html><head><title>Migrate your SAP Adapter 4.6 setup to Adapter for SAP version 10.1</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="home.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body>
    <h1>Migrate your SAP Adapter 4.6 setup to Adapter for SAP version 10.1</h1>

    <ul>
      <li><a href="/WmSAP/">Back to Adapter for SAP Home Page</a></li>
    </ul>

    <p>This form can be used to automatically migrate your SAP 
	    Adapter 4.6 setup for usage with Adapter for SAP version 10.1.</p>
    <p>The automatic migration process covers items 3 to 8 from
      section <em>Compatibility Considerations</em> from the webMethods
	Adapter for SAP Installation Guide, available from the
      <a href="http://documentation.softwareag.com/">Software AG Documentation
	Web site</a>.</p>
    <div class="note">
      <p><strong>Note.</strong> Before starting the migration
	process, you need to synchronize the map namespace nodes
	with the definitions as persisted in file
	<code><em>IntegrationServer</em>/packages/SAP/config/sap.cnf</code>.
	You do so from the SAP Adapter 4.6 Administrator UI at
	<em>SAP > SAP Servers > RFC Function Maps for
	  %serverName%</em> by clicking <em>Find Maps for
	  %serverName%</em>, selecting all found maps, and then
	clicking <em>Add</em>. Repeat this for each
	<em>%serverName%</em> defined.</p>
    </div>

    <ol>
      <li>Copy files <code>sap.cnf</code> and
	<code>cbr.cnf</code> from the 4.6 directory
	<code><em>IntegrationServer</em>/packages/SAP/config/</code>
	to the 10.1 directory
	<code><em>IntegrationServer</em>/packages/WmSAP/config/<code></li>
      <li>Copy file <code>gateway.cnf</code> from the 4.6 directory
	<code><em>IntegrationServer</em>/packages/WmPartners/config/</code>
	to the 10.1 directory
	<code><em>IntegrationServer</em>/packages/WmSAP/config/<code></li>
      <li>If you haven't organized your SAP Adapter 4.6 based
	application package yet that it contains all your <em>RFC
	  Inbound Maps</em>, <em>RFC Outbound Maps</em>, and
	<em>Routing Rules</em> do so by now: 
        <dl>
          <dt><em>RFC Inbound Maps</em></dt>
	  <dd>Use the Developer to ensure that your application
	    package contains all inbound map namespace
	    nodes. They are structured as
	    <code>sap.inbound.%serverName%:%rfcName%</code>.</dd>
          <dt><em>RFC Outbound Maps</em></dt>
	  <dd>Use the Developer to ensure that your application
	    package contains all outbound map namespace
	    nodes. They are structured as
	    <code>*.%serverName%:%rfcName%</code>.</dd> 
          <dt><em>Routing Rules</em></dt>
	  <dd>Use the Developer to ensure that your application
	    package contains all routing rule namespace
	    nodes. They are structured as
	    <code>wm.PartnerMgr.flows.%sender%.%receiver%:%msgType%</code>.</dd>
        </dl>
      </li>
      <li>Install your SAP Adapter 4.6 based application package at Integration Server version
	9.0 or later:
        <ul>
          <li>Place your SAP Adapter 4.6 based application
	    package into directory
	    <code><em>IntegrationServer</em>/replicate/inbound/</code></li>
          <li>In the Integration Server Administrator, select
	    <em>Packages > Management</em></li>
          <li>Click <em>Install Inbound Releases</em></li>
          <li>In the <em>Release file name</em> list, select your
	    SAP Adapter 4.6 based application package</li>
          <li>Click <em>Install Release</em></li>
        </ul>
      </li>
      <li>You are now ready to finish migration of the 4.6 SAP
	Adapter constructs to the Adapter 10.1 for SAP
	equivalents. Just hit the <code>Migrate</code> button
	below.</li>
    </ol>

    <div class="note">
      <p><strong>Note.</strong> Make sure that your SAP systems
	are available during the migration process as the utility
	requires an enabled connection to migrate <em>RFC Inbound
	  Maps</em> and <em>RFC Outbound Maps</em>. In case of an
	error, after solving the issue, you can just hit the
	<em>Migrate</em> button again to migrate the <b>remaining</b>
	constructs. After restarting the Integration Server and
	hitting the <em>Migrate</em> button <b>all</b> defined constructs
	will be updated/migrated again.</p>
    </div>

    <form class="form" action="/WmSAP/migrateSetup.dsp"
      method="post"><input type="submit" name="$action"
	value="Migrate"></input>
      
      <!-- %ifvar $action equals('Migrate')% -->
      <!-- %invoke wm.sap.Admin:migrateSLDData% -->
      
      <!-- %ifvar $message -notempty% -->
      <dl class="note">
	<!-- %loop $message -struct% -->
	<dt><strong>%value $key%</strong> ...</dt><dd>... %value%</dd>
	<!-- %endloop% -->
      </dl>
      <!-- %endif% -->

      <!-- %onerror% -->
      <!-- %ifvar $error% -->
      <dl class="note" style="color: red;">
	<dt><strong>Error</strong> ...</dt><dd>... %value $error%</dd>
	<dt><strong>Error type</strong> ...</dt><dd>... %value $errorType%</dd>
      </dl>
      <!-- %endif% -->
      <!-- %ifvar error% -->
      <dl class="note" style="color: red;">
	<dt><strong>Message</strong> ...</dt><dd>... %value errorMessage%</dd>
	<dt><strong>Service</strong> ...</dt><dd>... %value errorService%</dd>
      </dl>
      <!-- %endif% -->
      <!-- %ifvar message% -->
      <dl class="note" style="color: red;">
	<dt><strong>Message</strong> ...</dt><dd>... %value message%</dd>
      </dl>
      <!-- %endif% -->
      <!-- %endinvoke% -->
      <!-- %endif% -->
    </form>

    <div class="note">
      <p><strong>Note.</strong> The newly created <em>RFC
	  Listener Notifications</em> will all be disabled by
	default. In contrast, the <em>Routing Notifications</em>
	will be enabled or disabled based on the 4.6 routing rule
	setup.</p>
    </div>

    <div class="note">
      <p><strong>Note.</strong> By default, the notification
	order might not match your needs. Therefore you
	need to change the notification order for the <em>Routing
	Listener</em> and each <em>RFC Listener</em> defined.</p>
    </div>

    <div class="note">
      <p><strong>Note.</strong> Version 4.6 of the Adapter for SAP usually did populate the
	pipeline with values of type <code>java.lang.String</code> - independently of the actual
	data type as defined within SAP. This behavior has changed with this release and might
	require changes to your application logic.<br/>
	Instead, depending on the SAP dictionary type, you will now find values of data type
	<code>java.lang.Integer</code>, <code>java.lang.Double</code>, and <code>byte[]</code>
	in your pipeline during runtime. Before, these values were returned as
	<code>java.lang.String</code>, in case of SAP datatype <code>RAW</code>, as base64
	encoded string. For more details about the Adapter for SAP type system see the webMethods
	Adapter for SAP User's Guide Appendix C, available from the
	<a href="http://documentation.softwareag.com/">Software AG Documentation
	    Web site</a>.<br/>
	In some cases this might require changes to your application services, as previously
	as string returned values will now get returned as objects of type java.lang.Integer,
	java.lang.Double, or byte[].'</p>
    </div>
  </body>
</html>