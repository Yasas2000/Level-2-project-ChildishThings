import {useState} from "react";
import {ProSidebarProvider, Menu, MenuItem } from "react-pro-sidebar";
//import "react-pro-sidebar/dist/css/styles.css";
import { Box, IconButton, Typography, useTheme } from "@mui/material";
import {Link} from "react-router-dom";
import { tokens } from "../../theme";
import HomeOutlinedIcon  from "@mui/icons-material/HomeOutlined";
import PeopleOutlinedIcon  from "@mui/icons-material/PeopleOutlined";
import HelpOutlinedIcon  from "@mui/icons-material/HelpOutlined";
import CalendarTodayOutlinedIcon  from "@mui/icons-material/CalendarTodayOutlined";
import ChatOutlinedIcon  from "@mui/icons-material/ChatOutlined";
import SettingsOutlinedIcon  from "@mui/icons-material/SettingsOutlined";
import MenuOutlinedIcon from "@mui/icons-material/MenuOutlined";
import { borderRadius } from "@mui/system";
import { PeopleOutlineOutlined } from "@mui/icons-material";

const Item = ({title, to, icon, selected, setSelected}) =>{
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    return(
        <MenuItem 
            active ={selected === title} 
            style={{ color:colors.grey[400]}}
            onClick={() => setSelected(title)}
            icon = {icon}
        >
            <Typography>{title}</Typography>
            <link to={to} />
        </MenuItem>
    )
}

const Sidebar=() =>{
    const theme = useTheme();
    const colors = tokens(theme.palette.mode);
    const [isCollapsed, setIsCollapsed] = useState(false);
    const [selected, setSelected] = useState("Dashboard");

    return(
        <Box
            sx={{
                "& pro.sidebar.provider-inner":{
                    background:`${colors.primary[100]} !important`
                },
                "& pro.icon-wrapper":{
                    backgroundColor: "transparent !important",
                },
                "& pro.inner-item":{
                    padding: "5px 35px 5px 20px !important",
                },
                "& pro.inner-item:hover":{
                    color: " #868dfb !important",
                },
                "& pro.menu-item.active":{
                    color :"#6870fa !important"
                }
            }}
            >
                <ProSidebarProvider collapsed={isCollapsed}>
                    <Menu iconShape="Square">
                        {/* LOGO & MENU ICON */}
                        <MenuItem 
                        onClick={() => setIsCollapsed(!isCollapsed)}
                        icon={isCollapsed ? <MenuOutlinedIcon/>: undefined}
                        style={{
                                margin: "10px 0 20px 0",
                                color: colors.grey[100],
                            }}
                        >
                            {!isCollapsed &&(
                                <Box
                                    display="flex"
                                    justifyContent="space-between"
                                    allignment="center"
                                    ml="10px"
                                >
                                    <Typography varientt ="h3" color={colors.grey[100]}>
                                        ADMIN
                                    </Typography>
                                    <IconButton onClick={() => setIsCollapsed(!isCollapsed)}>
                                        <MenuOutlinedIcon/>
                                    </IconButton>
                                </Box>
                            )}
                        </MenuItem>
                        {/*USER*/}
                        {!isCollapsed && (
                            <Box mb="5px">
                                <Box display ="flex" justifyContent="center" alignItems="center">
                                    <img
                                        alt="profile-user"
                                        width="50px"
                                        height="50px"
                                        src={`../../logo512.png`}
                                        style={{cursor: "pointer", borderRadius: "50%"}}
                                    />
                                </Box>
                                <Box textAlign="center">
                                    <Typography 
                                        variant="h4" 
                                        color={colors.grey[200]} 
                                        fontWeight="bold" 
                                        sx={{m: "10px 0 0 0"}}
                                    >
                                        Username
                                    </Typography>
                                </Box>
                            </Box>
                        )}

                        {/*MENU ITEMS*/}
                        <Box paddingLeft={isCollapsed ? undefined : "5%"}>
                            <Item
                                title="Dashboard"
                                to="/"
                                icon={<HomeOutlinedIcon/>}
                                selected={selected}
                                setSelected={setSelected}
                            />
                            <Item
                                title="Users"
                                to="/users"
                                icon={<PeopleOutlinedIcon/>}
                                selected={selected}
                                setSelected={setSelected}
                            />
                            <Item
                                title="Requets"
                                to="/requests"
                                icon={<HelpOutlinedIcon/>}
                                selected={selected}
                                setSelected={setSelected}
                            />
                            <Item
                                title="Events"
                                to="/events"
                                icon={<CalendarTodayOutlinedIcon/>}
                                selected={selected}
                                setSelected={setSelected}
                            />
                            <Item
                                title="Chat"
                                to="/chat"
                                icon={<ChatOutlinedIcon/>}
                                selected={selected}
                                setSelected={setSelected}
                            />
                            <Item
                                title="Settings"
                                to="/settings"
                                icon={<SettingsOutlinedIcon/>}
                                selected={selected}
                                setSelected={setSelected}
                            />
                        </Box>
                    </Menu>
                </ProSidebarProvider>
        </Box>
    );
}

export default Sidebar;
