//<debug>
Ext.Loader.setPath({
    'Ext': '../../src'
});
//</debug>

/**
 * This simple example shows the ability of the Ext.List component.
 *
 * In this example, it uses a grouped store to show group headers in the list. It also
 * includes an indicator so you can quickly swipe through each of the groups. On top of that
 * it has a disclosure button so you can disclose more information for a list item.
 */

//define the application
Ext.application({
    //define the startupscreens for tablet and phone, as well as the icon
    startupImage: {
        '320x460': 'resources/startup/Default.jpg', // Non-retina iPhone, iPod touch, and all Android devices
        '640x920': 'resources/startup/640x920.png', // Retina iPhone and iPod touch
        '640x1096': 'resources/startup/640x1096.png', // iPhone 5 and iPod touch (fifth generation)
        '768x1004': 'resources/startup/768x1004.png', //  Non-retina iPad (first and second generation) in portrait orientation
        '748x1024': 'resources/startup/748x1024.png', //  Non-retina iPad (first and second generation) in landscape orientation
        '1536x2008': 'resources/startup/1536x2008.png', // : Retina iPad (third generation) in portrait orientation
        '1496x2048': 'resources/startup/1496x2048.png' // : Retina iPad (third generation) in landscape orientation
    },

    isIconPrecomposed: false,
    icon: {
        57: 'resources/icons/icon.png',
        72: 'resources/icons/icon@72.png',
        114: 'resources/icons/icon@2x.png',
        144: 'resources/icons/icon@144.png'
    },

    //require any components/classes what we will use in our example
    requires: [
		'Ext.tab.Panel',
		'Ext.form.*',
		'Ext.field.*',
		'Ext.Button',
		'Ext.Toolbar',
		'Ext.data.Store',
		'Ext.MessageBox',
		'Ext.List',
		'Ext.field.Search',
	    'Ext.Panel'
    ],

    /**
     * The launch method is called when the browser is ready, and the application can launch.
     *
     * Inside our launch method we create the list and show in in the viewport. We get the lists configuration
     * using the getListConfiguration method which we defined below.
     *
     * If the user is not on a phone, we wrap the list inside a panel which is centered on the page.
     */
    launch : function() {
		
		Ext.Viewport.add({
			xtype : 'tabpanel',
			id: 'mainTab',
			tabBar : {
				docked : 'bottom',
				layout : {
					pack : 'center',
					align : 'center'
				},
				scrollable : {
					direction : 'horizontal',
					indicators : false
				}
			},
			ui : 'light',
			defaults : {
				scrollable : true
			},
			layout : {
				animation : false
			},
			// next we define the items that will appear inside our tab panel
			items : [ {
				title : 'About',
				xtype : 'formpanel',
				items : [ {
					xtype : 'fieldset',
					title : 'Personal Info',
					items : [ {
	                        xtype: 'textfield',
	                        name: 'name',
	                        label: 'Name',
	                        autoCapitalize: false
	                    },
	                    {
	                        xtype: 'passwordfield',
	                        name: 'password',
	                        label: 'Password'
	                    },
	                    {
	                        xtype: 'toolbar',
	                        docked: 'bottom',
	                        scrollable: {
	                            direction: 'horizontal',
	                            directionLock: true
	                        },
	                        items: [{
	                            text: 'Submit',
	                            ui: 'confirm',
	                            scope: this,
	                            handler: function() {
	                                var form = this.form;

	                                form.submit({
	                                    url: 'user.json',
	                                    waitMsg: 'Saving User...'
	                                });
	                            }
	                        },   
	                        {
	                            text: 'Reset',
	                            // Ensure the scope is 'this' so we have access to the global 'form' instance
	                            scope: this,
	                            handler: function() {
	                                // Call the form.reset method
	                                this.form.reset();
	                            }
	                        }]
	                    }                    
                    ]
				} ],
				iconCls : 'info',
				cls : 'card1'
			}, {
				title : 'Favorites',
				xtype : 'list',
				itemTpl: '{firstName} {lastName}',
				store: this.getStore(),
				listeners: {
			        select: function(view, record) {
			            //Ext.Msg.alert('Selected!', 'You selected ' + record.get('firstName'));
			            Ext.getCmp('mainTab').setActiveItem(0);
			        }
			    },
				items: [
	                {
	                    xtype: 'toolbar',
	                    docked: 'top',
	                    items: [
	                        { xtype: 'spacer' },
	                        {
	                            xtype: 'searchfield',
	                            placeHolder: 'Search...',
	                            listeners: {
	                                scope: this,
	                                clearicontap: this.onSearchClearIconTap,
	                                keyup: this.onSearchKeyUp
	                            }
	                        },
	                        { xtype: 'spacer' }
	                    ]
	                }
			    ],
				iconCls : 'favorites',
				cls : 'card2'
			} ]
		});
	},
	
	 getStore: function() {
		//check if a store has already been set
	        if (!this.store) {
	            //if not, create one
	            this.store = Ext.create('Ext.data.Store', {
	                //define the stores fields
	                fields: ['firstName', 'lastName'],
	                //sort the store using the lastname field
	                sorters: 'lastName',
	                //group the store using the lastName field
	                groupField: 'lastName',
	                //and give it some data
	                data: [
	                    { firstName: 'Tommy',   lastName: 'Maintz' },
	                    { firstName: 'Rob',     lastName: 'Dougan' },
	                    { firstName: 'Ed',      lastName: 'Avins' },
	                    { firstName: 'Jamie',   lastName: 'Avins' },
	                    { firstName: 'Dave',    lastName: 'Dougan' },
	                    { firstName: 'Abraham', lastName: 'Elias' },
	                    { firstName: 'Jacky',   lastName: 'Ngyuyen' },
	                    { firstName: 'Jay',   lastName: 'Ngyuyen' },
	                    { firstName: 'Jay',     lastName: 'Robinson' },
	                    { firstName: 'Rob',   lastName: 'Avins' },
	                    { firstName: 'Ed',     lastName: 'Dougan' },
	                    { firstName: 'Jamie',    lastName: 'Poulden' },
	                    { firstName: 'Dave',      lastName: 'Spencer' },
	                    { firstName: 'Abraham',   lastName: 'Avins' },
	                    { firstName: 'Jacky',   lastName: 'Avins' },
	                    { firstName: 'Rob',    lastName: 'Kaneda' },
	                    { firstName: 'Ed', lastName: 'Elias' },
	                    { firstName: 'Tommy',    lastName: 'Dougan' },
	                    { firstName: 'Rob',     lastName: 'Robinson' }
	                ]
	            });
	        }

	        //return the store instance
	        return this.store;
	 },
	
	 onSearchKeyUp: function(field) {
		//get the store and the value of the field
	        var value = field.getValue(),
	            store = this.getStore();

	        //first clear any current filters on the store. If there is a new value, then suppress the refresh event
	        store.clearFilter(!!value);

	        //check if a value is set first, as if it isnt we dont have to do anything
	        if (value) {
	            //the user could have entered spaces, so we must split them so we can loop through them all
	            var searches = value.split(','),
	                regexps = [],
	                i, regex;

	            //loop them all
	            for (i = 0; i < searches.length; i++) {
	                //if it is nothing, continue
	                if (!searches[i]) continue;

	                regex = searches[i].trim();
	                regex = regex.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");

	                //if found, create a new regular expression which is case insenstive
	                regexps.push(new RegExp(regex.trim(), 'i'));
	            }

	            //now filter the store by passing a method
	            //the passed method will be called for each record in the store
	            store.filter(function(record) {
	                var matched = [];

	                //loop through each of the regular expressions
	                for (i = 0; i < regexps.length; i++) {
	                    var search = regexps[i],
	                        didMatch = search.test(record.get('firstName') + ' ' + record.get('lastName'));

	                    //if it matched the first or last name, push it into the matches array
	                    matched.push(didMatch);
	                }

	                return (regexps.length && matched.indexOf(true) !== -1);
	            });
	        }
	 },
	
	 onSearchClearIconTap: function() {
		 this.getStore().clearFilter();
    }
	
});
