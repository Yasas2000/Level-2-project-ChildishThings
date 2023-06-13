import "./App.css";
import SideBar from "./components/Sidebar";
import Header from "./components/Header";
import {BrowserRouter as Router, Routes ,Route} from "react-router-dom";
import Home from "./pages/Home";
import Users from "./pages/Users";
import Requests from "./pages/Requests";
import Analytics from "./pages/Analytics";
import Events from "./pages/Events";
import RegisteredUsers from "./pages/RegisteredUsers";
import StripeQuotRequests from "./pages/stripeQuotationRequests";
import PortraitQuotRequests from "./pages/portraitQuotationRequest";
import Donations from "./pages/Donations";
import EducationalHelpRequests from "./pages/EducationalHelpRequests";
import FinancialHelpRequests from "./pages/FinancialHelpRequest";
import Notifications from "./pages/Notification";
import Feedback from "./pages/Feedback";


function App() {
  return (
    <Router>
      <SideBar>  
      <Header/>
        
          <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/users" element={<Users />} />
          <Route path="/users/registeredUsers" element={<RegisteredUsers/>} />
          <Route path="/Requests" element={<Requests />} />
          <Route path="/Requests/stripeQuotationRequests" element={<StripeQuotRequests/>}/>
          <Route path="/Requests/portraitQuotationRequests" element={<PortraitQuotRequests/>}/>
          <Route path="/Requests/donations" element={<Donations />} />
          <Route path="/Requests/EducationalHelpRequests" element={<EducationalHelpRequests/>}/>
          <Route path="/Requests/FinancialHelpRequests" element={<FinancialHelpRequests/>}/>
          <Route path="/analytics" element={<Analytics />} />
          <Route path="/Events" element={<Events />} />
          <Route path="/Notification" element={<Notifications/>}/>
          <Route path="/Feedback" element={<Feedback/>}/>
          <Route path="*" element={<> not found</>} />
        </Routes> 
      </SideBar>
    </Router>
  );
}

export default App;