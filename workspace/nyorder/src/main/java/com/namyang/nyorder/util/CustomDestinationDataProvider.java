package com.namyang.nyorder.util;

import java.util.HashMap;
import java.util.Properties;

import com.sap.conn.jco.ext.DataProviderException;
import com.sap.conn.jco.ext.DestinationDataEventListener;
import com.sap.conn.jco.ext.DestinationDataProvider;

public class CustomDestinationDataProvider implements DestinationDataProvider{
		
	private DestinationDataEventListener eL;
	private HashMap<String, Properties> secureDBStorage = new HashMap<String, Properties>();
		
	public void setDestinationProperties(Properties sysProp)
	{
		Properties connProp = new Properties();

		connProp.setProperty(DestinationDataProvider.JCO_ASHOST, sysProp.getProperty("JCO.AsHost"));
		connProp.setProperty(DestinationDataProvider.JCO_MSSERV, sysProp.getProperty("JCO.MsPort"));		
		connProp.setProperty(DestinationDataProvider.JCO_SYSNR,  sysProp.getProperty("JCO.SysNr"));		
		connProp.setProperty(DestinationDataProvider.JCO_CLIENT, sysProp.getProperty("JCO.Client"));		
		connProp.setProperty(DestinationDataProvider.JCO_USER,   sysProp.getProperty("JCO.User"));
		connProp.setProperty(DestinationDataProvider.JCO_PASSWD, sysProp.getProperty("JCO.Passwd"));
		connProp.setProperty(DestinationDataProvider.JCO_LANG,   sysProp.getProperty("JCO.Lang"));
		connProp.setProperty(DestinationDataProvider.JCO_GROUP,  sysProp.getProperty("JCO.Group"));
		
		connProp.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, sysProp.getProperty("JCO.PoolCapacity"));
		connProp.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT,    sysProp.getProperty("JCO.PeakLimit"));
		
		secureDBStorage.put(sysProp.getProperty("JCO.NYC_DEST_NAME"), connProp);
		secureDBStorage.put(sysProp.getProperty("JCO.NYC_DEST_NAME_POOLED"), connProp);
	}

	public Properties getDestinationProperties(String destinationName)
	{
		try
		{
			//read the destination from DB
			Properties connProp = secureDBStorage.get(destinationName);

			if(connProp != null)
			{
				//check if all is correct, for example
				if(connProp.isEmpty())
					throw new DataProviderException(DataProviderException.Reason.INVALID_CONFIGURATION, "destination configuration is incorrect", null);

				return connProp;
			}
			return null;
		}
		catch(RuntimeException re)
		{
			throw new DataProviderException(DataProviderException.Reason.INTERNAL_ERROR, re);
		}
	}

	//An implementation supporting events has to retain the eventListener instance provided
	//by the JCo runtime. This listener instance shall be used to notify the JCo runtime
	//about all changes in destination configurations.
	public void setDestinationDataEventListener(DestinationDataEventListener eventListener)
	{
		this.eL = eventListener;
	}

	public boolean supportsEvents()
	{
		return true;
	}

	//implementation that saves the properties in a very secure way
	void changeProperties(String destName, Properties properties)
	{
		synchronized(secureDBStorage)
		{
			if(properties==null)
			{
				if(secureDBStorage.remove(destName)!=null)
					eL.deleted(destName);
			}
			else 
			{
				secureDBStorage.put(destName, properties);
				eL.updated(destName); // create or updated
			}
		}
	}

}
