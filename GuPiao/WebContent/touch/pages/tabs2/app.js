//<debug>
Ext.Loader.setPath({
    'Ext': '../../src'
});
//</debug>

/**
 * This is a simple demo of the TabPanel component in Sencha Touch.
 *
 * This is similar to the other tabs example, only the tabbar is docked to the bottom.
 */
Ext.application({
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

    //require any components we use in the application
    requires: [
        'Ext.tab.Panel',
        'Ext.form.*',
        'Ext.field.*',
        'Ext.Button',
        'Ext.Toolbar',
        'Ext.data.Store',
        'Ext.MessageBox',
        'Ext.List',
        'Ext.plugin.PullRefresh'
    ],

    /**
     * The launch function is called when the browser and the framework is ready
     * for the application to launch.
     *
     * All we are going to do is create a simple tabpanel with some items, and add
     * it to the global Ext.Viewport instance.
     */
    launch: function() {
    	
        //we send a config block into the Ext.Viewport.add method which will
        //create our tabpanel
        Ext.Viewport.add({
            //first we define the xtype, which is tabpanel for the Tab Panel component
            xtype: 'tabpanel',

            //now we specify the tabBar configuration and give it a docked property of bottom
            //this will dock the tabbar of this tabpanel to the bottom

            tabBar: {
                // Dock it to the bottom
                docked: 'bottom',

                // Change the layout so each of the tabs are centered vertically and horizontally
                layout: {
                    pack: 'center',
                    align: 'center'
                },

                // Make the tabbar scrollable horizontally, and disabled the indicators
                scrollable: {
                    direction: 'horizontal',
                    indicators: false
                }
            },

            //here we specify the ui of the tabbar to light
            ui: 'light',

            //defaults allow us to add default configuratons for each of the items added into
            //this container. adding scrollable true means that all items in this tabpanel will
            //be scrollable unless otherwise specified in the item configuration
            defaults: {
                scrollable: true
            },

            layout: {
                animation: false
            },

            //next we define the items that will appear inside our tab panel
            items: [
                {
                    //each item in a tabpanel requires the title configuration. this is displayed
                    //on the tab for this item
                    title: 'About',
                    xtype: 'formpanel',
                    items:[{
                        xtype: 'fieldset',
                        title: 'Personal Info',
                        items: [
                        ]
                    }],
                    iconCls: 'info',
                    cls: 'card1'
                },
                {
                    title: 'Favorites',
                    xtype: 'list',
                    iconCls: 'favorites',
                    cls: 'card2',
                    badgeText: '4'
                },
                {
                    title: 'Downloads',
                    html: '<h1>Downloads Card</h1>',
                    iconCls: 'download',
                    cls: 'card3',
                    badgeText: 'Text can go here too, but it will be cut off if it is too long.'
                },
                {
                    title: 'Settings',
                    html: '<h1>Settings Card</h1>',
                    iconCls: 'settings',
                    cls: 'card4'
                },
                {
                    title: 'User',
                    html: '<h1>User Card</h1>',
                    iconCls: 'user',
                    cls: 'card5'
                }
            ]
        });
    }
    
    
    
    
    
    
});
