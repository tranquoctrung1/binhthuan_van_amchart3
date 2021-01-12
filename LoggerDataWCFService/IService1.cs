using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace LoggerDataWCFService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
           ResponseFormat = WebMessageFormat.Json,
           UriTemplate = "GetData/{value}")]
        string GetData(string value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        [OperationContract]
        [WebGet(BodyStyle=WebMessageBodyStyle.Wrapped, 
            ResponseFormat=WebMessageFormat.Json, 
            UriTemplate="GetSites")]
        IEnumerable<SiteViewModel> GetSites();

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetSitesByUid/{uid}")]
        IEnumerable<SiteViewModel> GetSitesByUid(string uid);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
          ResponseFormat = WebMessageFormat.Json,
          UriTemplate = "GetSitesByUidDMA/{uid}")]
        IEnumerable<SiteViewModel> GetSitesByUidDMA(string uid);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetAlarms")]
        IEnumerable<AlarmViewModel> GetAlarms();

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetSite/{id}")]
        IEnumerable<SiteViewModel> GetSite(string id);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetChannels/{loggerId}")]
        IEnumerable<ChannelViewModel> GetChannels(string loggerId);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetChannelById/{id}")]
        IEnumerable<ChannelViewModel> GetChannelById(string id);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetChannelData/{channelId}/{start}/{end}")]
        IEnumerable<ChannelDataViewModel> GetChannelData(string channelId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
           ResponseFormat = WebMessageFormat.Json,
           UriTemplate = "GetChannelDataChart/{channelId}/{start}/{end}")]
        IEnumerable<ChannelDataViewModel> GetChannelDataChart(string channelId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
          ResponseFormat = WebMessageFormat.Json,
          UriTemplate = "GetChannelDataMonthly/{siteId}/{start}/{end}")]
        IEnumerable<ChannelDataViewModel> GetChannelDataMonthly(string siteId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
           ResponseFormat = WebMessageFormat.Json,
           UriTemplate = "GetChannelDatadaily/{siteId}/{start}/{end}")]
        IEnumerable<ChannelDataViewModel> GetChannelDataDaily(string siteId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
          ResponseFormat = WebMessageFormat.Json,
          UriTemplate = "GetChannelDataHourly/{siteId}/{start}/{end}")]
        IEnumerable<ChannelDataViewModel> GetChannelDataHourly(string siteId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
          ResponseFormat = WebMessageFormat.Json,
          UriTemplate = "GetChannelDataYearly/{siteId}/{start}/{end}")]
        IEnumerable<ChannelDataViewModel> GetChannelDataYearly(string siteId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetMultipleChannelsData/{listChannelId}/{start}/{end}")]
        IEnumerable<ChannelMultipleDataViewModel> GetMultipleChannelsData(string listChannelId, string start, string end);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
         ResponseFormat = WebMessageFormat.Json,
         UriTemplate = "GetDailyComplexData/{loggerID}/{startDate}/{endDate}")]
        IEnumerable<ComplexDataViewModelkq> GetDailyComplexData(string loggerID, string startDate, string endDate);

        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Wrapped,
         ResponseFormat = WebMessageFormat.Json,
         UriTemplate = "Test")]
        string Test();

    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class ComplexDataViewModelkq
    {
        DateTime timeStamp;
        double? output;
        double? minPressure;
        double? minFlowRate;
        double? maxFlowRate;
        double? maxPressure;
        double? mNF;
        [DataMember]
        public DateTime TimeStamp
        {
            get
            {
                return timeStamp;
            }

            set
            {
                timeStamp = value;
            }
        }
        [DataMember]
        public double? Output
        {
            get
            {
                return output;
            }

            set
            {
                output = value;
            }
        }
        [DataMember]
        public double? MinPressure
        {
            get
            {
                return minPressure;
            }

            set
            {
                minPressure = value;
            }
        }
        [DataMember]
        public double? MinFlowRate
        {
            get
            {
                return minFlowRate;
            }

            set
            {
                minFlowRate = value;
            }
        }
        [DataMember]
        public double? MaxFlowRate
        {
            get
            {
                return maxFlowRate;
            }

            set
            {
                maxFlowRate = value;
            }
        }
        [DataMember]
        public double? MaxPressure
        {
            get
            {
                return maxPressure;
            }

            set
            {
                maxPressure = value;
            }
        }
        [DataMember]
        public double? MNF
        {
            get
            {
                return mNF;
            }

            set
            {
                mNF = value;
            }
        }
    }

    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }
    public class ComplexDataViewModel
    {
        DateTime timeStamp;
        double? forwardFlow;
        double? reverseFlow;
        double? minForwardFlow;
        double? minreverseFlow;
        double? maxforwardFlow;
        double? maxreverseFlow;
        double? minpressure1;
        double? minpressure2;

        [DataMember]
        public double? ForwardFlow
        {
            get
            {
                return forwardFlow;
            }

            set
            {
                forwardFlow = value;
            }
        }
        [DataMember]
        public DateTime TimeStamp
        {
            get
            {
                return timeStamp;
            }

            set
            {
                timeStamp = value;
            }
        }
        [DataMember]
        public double? ReverseFlow
        {
            get
            {
                return reverseFlow;
            }

            set
            {
                reverseFlow = value;
            }
        }
        [DataMember]
        public double? MinForwardFlow
        {
            get
            {
                return minForwardFlow;
            }

            set
            {
                minForwardFlow = value;
            }
        }
        [DataMember]
        public double? MinreverseFlow
        {
            get
            {
                return minreverseFlow;
            }

            set
            {
                minreverseFlow = value;
            }
        }
        [DataMember]
        public double? MaxforwardFlow
        {
            get
            {
                return maxforwardFlow;
            }

            set
            {
                maxforwardFlow = value;
            }
        }
        [DataMember]
        public double? MaxreverseFlow
        {
            get
            {
                return maxreverseFlow;
            }

            set
            {
                maxreverseFlow = value;
            }
        }
        [DataMember]
        public double? Minpressure1
        {
            get
            {
                return minpressure1;
            }

            set
            {
                minpressure1 = value;
            }
        }
        [DataMember]
        public double? Minpressure2
        {
            get
            {
                return minpressure2;
            }

            set
            {
                minpressure2 = value;
            }
        }



    }
    //For Logger Channel Configuration
    [DataContract]
    public class ChannelConfig
    {
        string channelId;
        string loggerId;
        string channelName;
        string unit;
        string description;
        bool pressure1;
        bool pressure2;
        bool forwardFlow;
        bool reverseFlow;
        DateTime? timestamp;
        double? lastValue;
        DateTime? indexTimestamp;
        double? lastIndex;

        [DataMember]
        public string ChannelId
        {
            get { return channelId; }
            set { channelId = value; }
        }

        [DataMember]
        public string LoggerId
        {
            get { return loggerId; }
            set { loggerId = value; }
        }

        [DataMember]
        public string ChannelName
        {
            get { return channelName; }
            set { channelId = value; }
        }

        [DataMember]
        public string Unit
        {
            get { return unit; }
            set { unit = value; }
        }

        [DataMember]
        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        [DataMember]
        public bool Pressure1
        {
            get { return pressure1; }
            set { pressure1 = value; }
        }

        [DataMember]
        public bool Pressure2
        {
            get { return pressure2; }
            set { pressure2 = value; }
        }

        [DataMember]
        public bool ForwardFlow
        {
            get { return forwardFlow; }
            set { forwardFlow = value; }
        }
        
        [DataMember]
        public bool ReverseFlow
        {
            get { return reverseFlow; }
            set { reverseFlow = value; }
        }

        [DataMember]
        public DateTime? Timestamp
        {
            get { return timestamp; }
            set { timestamp = value; }
        }

        [DataMember]
        public double? LastValue
        {
            get { return lastValue; }
            set { lastValue = value; }
        }

        [DataMember]
        public DateTime? IndexTimestamp
        {
            get { return indexTimestamp; }
            set { indexTimestamp = value; }
        }

        [DataMember]
        public double? LastIndex
        {
            get { return lastIndex; }
            set { lastIndex = value; }
        }
    }


    //For Logger Configuration
    [DataContract]
    public class LoggerConfig
    {
        string loggerId;
        string siteId;
        byte? startHour;
        string telephoneNumber;
        byte? pressure1;
        byte? pressure2;
        byte? forwardFlow;
        byte? reverseFlow;
        bool? alarm;

        [DataMember]
        public string LoggerId
        {
            get { return loggerId; }
            set { loggerId = value; }
        }

        [DataMember]
        public string SiteId
        {
            get { return siteId; }
            set { siteId = value; }
        }

        [DataMember]
        public byte? StartHour
        {
            get { return startHour; }
            set { startHour = value; }
        }

        [DataMember]
        public string TelephoneNumber
        {
            get { return telephoneNumber; }
            set { telephoneNumber = value; }
        }

        [DataMember]
        public byte? Pressure1
        {
            get { return pressure1; }
            set { pressure1 = value; }
        } 

        [DataMember]
        public byte? Pressure2
        {
            get { return pressure2; }
            set { pressure2 = value; }
        }

        [DataMember]
        public byte? ForwardFlow
        {
            get { return forwardFlow; }
            set { forwardFlow = value; }
        }

        [DataMember]
        public byte? ReverseFlow
        {
            get { return reverseFlow; }
            set { reverseFlow = value; }
        }

        [DataMember]
        public bool? Alarm
        {
            get { return alarm; }
            set { alarm = value; }
        }
    }

    //For Logger Site Configuration
    [DataContract]
    public class SiteConfig
    {
        string siteId;
        string siteAliasName;
        string location;
        double? latitude;
        double? longitude;
        string displayGroup;
        byte? zoom;
        string consumerId;
        string loggerId;
        byte? startDay;
        string description;
        string meterSerialNr;
        string transmitterSerialNr;
        string loggerSerialNr;
        DateTime? meterDateChanged;
        DateTime? transmitterDateChanged;
        DateTime? loggerDateChanged;
        string availability;
        string status;
        string staffs;
        int? labelAnchorX;
        int? labelAnchorY;
        double? labelLat;
        double? labelLng;
        string pipeSize;

        [DataMember]
        public string SiteId
        {
            get { return siteId; }
            set { siteId = value; }
        }

        [DataMember]
        public string SiteAliasName
        {
            get { return siteAliasName; }
            set { siteAliasName = value; }
        }

        [DataMember]
        public string Location
        {
            get { return location; }
            set { location = value; }
        }

        [DataMember]
        public double? Latitude
        {
            get { return latitude; }
            set { latitude = value; }
        }

        [DataMember]
        public double? Longitude
        {
            get { return longitude; }
            set { longitude = value; }
        }

        [DataMember]
        public string DisplayGroup
        {
            get { return displayGroup; }
            set { displayGroup = value; }
        }

        [DataMember]
        public byte? Zoom
        {
            get { return zoom; }
            set { zoom = value; }
        }
    }

    //For Map View
    [DataContract]
    public class SiteViewModel
    {
        string siteId;
        double? baseLine;
        string displayGroup;
        string location;
        string loggerId;
        double? latitude;
        double? longitude;
        int? labelAnchorX;
        int? labelAnchorY;
        double? index;
        string role;
        IEnumerable<ChannelViewModel> channels;

        [DataMember]
        public string SiteId
        {
            get { return siteId; }
            set { siteId = value; }
        }
        [DataMember]
        public double? BaseLine
        {
            get { return baseLine; }
            set { baseLine = value; }
        }
        [DataMember]
        public string DisplayGroup
        {
            get { return displayGroup; }
            set { displayGroup = value; }
        }

        [DataMember]
        public string Location
        {
            get { return location; }
            set { location = value; }
        }

        [DataMember]
        public string LoggerId
        {
            get { return loggerId; }
            set { loggerId = value; }
        }

        [DataMember]
        public double? Latitude
        {
            get { return latitude; }
            set { latitude = value; }
        }

        [DataMember]
        public double? Longitude
        {
            get { return longitude; }
            set { longitude = value; }
        }

        [DataMember]
        public int? LabelAnchorX
        {
            get { return labelAnchorX; }
            set { labelAnchorX = value; }
        }

        [DataMember]
        public int? LabelAnchorY
        {
            get { return labelAnchorY; }
            set { labelAnchorY = value; }
        }

        [DataMember]
        public double? Index
        {
            get { return index; }
            set { index = value; }
        }

        [DataMember]
        public string Role
        {
            get { return role; }
            set { role = value; }
        }

        [DataMember]
        public IEnumerable<ChannelViewModel> Channels
        {
            get { return channels; }
            set { channels = value; }
        }
    }

    //For Map View
    [DataContract]
    public class ChannelViewModel
    {
        string channelId;
        string channelName;
        bool? press1;
        bool? press2;
        DateTime? timestamp;
        DateTime? indexTimestamp;
        double? val;
        double? lastIndex;
        bool flow;
        string unit;
        int status;
        bool status1;
        bool status2;
        bool status3;
        bool status4;
        bool status5;
        bool status6;

        [DataMember]
        public bool Status1
        {
            get { return status1; }
            set { status1 = value; }
        }

        [DataMember]
        public bool Status2
        {
            get { return status2; }
            set { status2 = value; }
        }

        [DataMember]
        public bool Status3
        {
            get { return status3; }
            set { status3 = value; }
        }

        [DataMember]
        public bool Status4
        {
            get { return status4; }
            set { status4 = value; }
        }
        [DataMember]
        public bool Status5
        {
            get { return status5; }
            set { status5 = value; }
        }

        [DataMember]
        public bool Status6
        {
            get { return status6; }
            set { status6 = value; }
        }

        [DataMember]
        public string ChannelId
        {
            get { return channelId; }
            set { channelId = value; }
        }

        [DataMember]
        public string ChannelName
        {
            get { return channelName; }
            set { channelName = value; }
        }

        [DataMember]
        public bool? Press1
        {
            get { return press1; }
            set { press1 = value; }
        }

        [DataMember]
        public bool? Press2
        {
            get { return press2; }
            set { press2 = value; }
        }

        [DataMember]
        public DateTime? Timestamp
        {
            get { return timestamp; }
            set { timestamp = value; }
        }

        [DataMember]
        public DateTime? IndexTimestamp
        {
            get { return indexTimestamp; }
            set { indexTimestamp = value; }
        }

        [DataMember]
        public double? Value
        {
            get { return val; }
            set { val = value; }
        }

        [DataMember]
        public bool Flow
        {
            get { return flow; }
            set { flow = value; }
        }

        [DataMember]
        public double? LastIndex
        {
            get { return lastIndex; }
            set { lastIndex = value; }
        }

        [DataMember]
        public string Unit
        {
            get { return unit; }
            set { unit = value; }
        }

        [DataMember]
        public int Status
        {
            get { return status; }
            set { status = value; }
        }
    }
    //For Channel Data Daily
    [DataContract]
    public class ChannelDataDailyViewModel
    {
        DateTime timestamp;
        double? val;

        [DataMember]
        public DateTime Timestamp
        {
            get { return timestamp; }
            set { timestamp = value; }
        }

        [DataMember]
        public double? Value
        {
            get { return val; }
            set { val = value; }
        }
    }

    //For Channel Data
    [DataContract]
    public class ChannelDataViewModel
    {
        DateTime timestamp;
        double? val;

        [DataMember]
        public DateTime Timestamp
        {
            get { return timestamp; }
            set { timestamp = value; }
        }

        [DataMember]
        public double? Value
        {
            get { return val; }
            set { val = value; }
        }
    }

    //For Channel Data
    [DataContract]
    public class ChannelMultipleDataViewModel
    {
        DateTime timestamp;
        List<double?> val;

        [DataMember]
        public DateTime Timestamp
        {
            get { return timestamp; }
            set { timestamp = value; }
        }

        [DataMember]
        public List<double?> Values
        {
            get { return val; }
            set { val = value; }
        }
    }

    //For Alarm Data
    public class AlarmViewModel
    {
        string alarmTme;
        string entryTme;
        string id;
        string siteName;
        string descript;
        string priority;

        [DataMember]
        public string AlarmTme
        {
            get { return alarmTme; }
            set { alarmTme = value; }
        }

        [DataMember]
        public string EntryTme
        {
            get { return entryTme; }
            set { entryTme = value; }
        }

        [DataMember]
        public string Id
        {
            get { return id; }
            set { id = value; }
        }

        [DataMember]
        public string SiteName
        {
            get { return siteName; }
            set { siteName = value; }
        }

        [DataMember]
        public string Descript
        {
            get { return descript; }
            set { descript = value; }
        }

        [DataMember]
        public string Priority
        {
            get { return priority; }
            set { priority = value; }
        }
    }
}
