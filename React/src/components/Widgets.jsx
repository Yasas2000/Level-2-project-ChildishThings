import "./Widgets.css"

function Widgets() {
  return (
    <div className="widgets">
      <div className="eventsCorner">
        
      </div>
      <div className="heading">
        <span className="headingTitle">Users</span>
      </div>
      <div className="topWidget">
      <div className="widgetItem">
        <span className="widgetTitle">Registered Users</span>
        <div className="countContainer">
          <span className="count">1280</span>
        </div>
      </div>
      <div className="widgetItem">
        <span className="widgetTitle">Non-Registered Users</span>
        <div className="countContainer">
          <span className="count">789</span>
        </div>
      </div>
      <div className="widgetItem">
        <span className="widgetTitle">Online Users</span>
        <div className="countContainer">
          <span className="count">130</span>
        </div>
      </div>
      </div>
      <div className="heading">
        <span className="headingTitle">Requests</span>
      </div>
      <div className="bottomWidget">
      <div className="widgetItem">
        <span className="widgetTitle">Quotation Requests</span>
        <div className="countContainer">
          <span className="count">340</span>
        </div>
      </div>
      <div className="widgetItem">
        <span className="widgetTitle">Donations</span>
        <div className="countContainer">
          <span className="count">110</span>
        </div>
      </div>
      <div className="widgetItem">
        <span className="widgetTitle">Help Requests</span>
        <div className="countContainer">
          <span className="count">32</span>
        </div>
      </div>
      </div>
    </div>
    
  )
}

export default Widgets