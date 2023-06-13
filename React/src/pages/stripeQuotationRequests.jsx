import StripeQuotRequestList from "../components/StripeQuotRequestList";


const StripeQuotRequests = () => {
    return( 
      <div className="StripeQuotRequest">
        <div className="listContainer">
          <StripeQuotRequestList/>
        </div>
      </div>
    );
  }

  export default StripeQuotRequests;