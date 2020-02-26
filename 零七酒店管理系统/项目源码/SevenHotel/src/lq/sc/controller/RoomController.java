package lq.sc.controller;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lq.sc.pojo.CheckIn;
import lq.sc.pojo.Room;
import lq.sc.pojo.RoomType;
import lq.sc.service.checkIn.CheckInService;
import lq.sc.service.member.MemberService;
import lq.sc.service.order.OrderService;
import lq.sc.service.room.RoomService;
import lq.sc.service.roomtype.RoomTypeService;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;



/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：RoomController  
* 类描述：房间控制层  
* 创建人：lhh  
* 创建时间：2018-10-20 上午10:30:38
* @version   
*   
 */
@Controller
@RequestMapping("/room")
public class RoomController {
	@Resource
	private RoomTypeService roomTypeService;
	@Resource
	private RoomService roomService;
	@Resource
	private CheckInService checkInService;
	@Resource
	private MemberService memberService;
	@Resource
	private OrderService orderService;
	/*
	 * 404页面
	 */
	@RequestMapping("*")
	public String fourZeroFour(){
		return "customer_404";
	}
	/*
	 * 查询所有房间类别
	 */
	@RequestMapping(value="/main",method=RequestMethod.GET)
	public String selAllRoomType(Model model){
		model.addAttribute("BZRoom", roomTypeService.selBZRoom());
		model.addAttribute("HHRoom", roomTypeService.selHHRoom());
		model.addAttribute("OtherRoom",roomTypeService.selOtherRoom());
		model.addAttribute("AllRoom", roomTypeService.selAllRoomType());
		model.addAttribute("memberList",memberService.getAllMember());
		model.addAttribute("topThreeRoom", orderService.selTopThree());
		return "customer_main";
	}
	/*
	 * 查询所有酒店博客页面
	 */
	@RequestMapping(value="/blog",method=RequestMethod.GET)
	public String customer_blog(Model model){
		model.addAttribute("BZRoom", roomTypeService.selBZRoom());
		model.addAttribute("HHRoom", roomTypeService.selHHRoom());
		model.addAttribute("OtherRoom",roomTypeService.selOtherRoom());
		model.addAttribute("AllRoom", roomTypeService.selAllRoomType());
		model.addAttribute("memberList",memberService.getAllMember());
		model.addAttribute("topThreeRoom", orderService.selTopThree());
		return "customer_blog";
	}
	/*
	 * 查询所有酒店服务页面
	 */
	@RequestMapping(value="/services",method=RequestMethod.GET)
	public String customer_services(Model model){
		model.addAttribute("BZRoom", roomTypeService.selBZRoom());
		model.addAttribute("HHRoom", roomTypeService.selHHRoom());
		model.addAttribute("OtherRoom",roomTypeService.selOtherRoom());
		model.addAttribute("AllRoom", roomTypeService.selAllRoomType());
		model.addAttribute("memberList",memberService.getAllMember());
		model.addAttribute("topThreeRoom", orderService.selTopThree());
		return "customer_services";
	}
	/*
	 * 通过id查询房间类型(ajax)
	 */
	@RequestMapping(value="/selRoomTypeById",method=RequestMethod.GET)
	@ResponseBody
	public Object selRoomTypeById(@RequestParam("roomTypeId") String roomTypeId){
		return (RoomType)roomTypeService.selRoomType_ById(Integer.parseInt(roomTypeId));
	}
	/*
	 * 通过id查询房间剩余数(ajax)
	 */
	@RequestMapping(value="/selRoomCountByType",method=RequestMethod.GET)
	@ResponseBody
	public Object selRoomCountByType(@RequestParam("roomTypeId") String roomTypeId){
		return roomService.selRoomCountByType(Integer.parseInt(roomTypeId));
	}
	/*
	 * 通过房型id查询房型剩余的房间(ajax)
	 */
	@RequestMapping(value="/selRoomByRoomTypeIdAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object selRoomByRoomTypeIdAjax(@RequestParam("roomTypeId") String roomTypeId){
		List<Room> roomList=roomService.selRoomByRoomTypeId(Integer.parseInt(roomTypeId));
		return roomList;
	}
	/*
	 * 查询已入住的房间(ajax)
	 */
	@RequestMapping(value="/selRoomByIdAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selRoomByIdAjax(@RequestParam("roomId") String roomId){
		List<CheckIn> checkInList=checkInService.selRoomById(Integer.parseInt(roomId));
		return checkInList;
	}
	/*
	 * 入住结束更改房间状态为离店(ajax)
	 */
	@RequestMapping(value="/modifyCheckStateByIdAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object modifyCheckStateByIdAjax(@RequestParam("checkState") String checkState,
			@RequestParam("checkId") String checkId){
		Map<String, String> result=new HashMap<String, String>();
		if(checkInService.modifyCheckStateById(Integer.parseInt(checkState),Integer.parseInt(checkId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 修改房间类型(ajax)
	 */
	@RequestMapping(value="/modifyRoomTypeAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object modifyRoomTypeAjax(@RequestParam(value="roomImgFile",required=false)MultipartFile roomImgFile,
			@RequestParam(value="roomTypeName",required=false)String roomTypeName,
			@RequestParam(value="sketch",required=false)String sketch,
			@RequestParam(value="describe",required=false)String describe,
			@RequestParam(value="typePrice",required=false)String typePrice,
			@RequestParam(value="roomTypeId",required=false)String roomTypeId,
			HttpSession session,HttpServletRequest req){
		String fileName=null;
		File file=null;
		if(roomImgFile!=null){
			//1.是否有上传文件
			if(!roomImgFile.isEmpty()){
				//2.设置文件存放路径
				String path=req.getSession().getServletContext().getRealPath("/static/")+File.separator+"admin"+File.separator+"images"+File.separator+"room";
				//3.获取原文件名
				String originalName=roomImgFile.getOriginalFilename();
				//4.判断文件大小
				int size=500000;
				//5.获得文件后缀名
				String suffix=FilenameUtils.getExtension(originalName);
				if(roomImgFile.getSize()>size){
					req.setAttribute("fileError_PIC", "上传的文件过大,请重新上传!");
					return "useradd";
				}else if(suffix.equalsIgnoreCase("jpg")||
						suffix.equalsIgnoreCase("jpeg")||
						suffix.equalsIgnoreCase("png")||
						suffix.equalsIgnoreCase("pneg")
						){
					//修改的话得到原名路径
					RoomType roomType=roomTypeService.selRoomType_ById(Integer.parseInt(roomTypeId));
					String roomImg=roomType.getRoomImg();
					fileName=roomImg.substring(roomImg.length()-22);
					file=new File(path,fileName);
					//如果文件不存在就创建一个
					if(!file.exists()){
						file.mkdirs();
					}
					try {
						roomImgFile.transferTo(file);
					} catch (Exception e) {
						req.setAttribute("fileError_ROOM", e.getMessage());
					}
				}else{
					req.setAttribute("fileError_ROOM", "上传的文件后缀不满足,请重新上传!");
				}
			}
		}
		Map<String, String> result=new HashMap<String, String>();
		RoomType modifyRoomType=new RoomType();
		//修改房间类型的路径不用更改，只需要将图片覆盖过去就行
		modifyRoomType.setDescribe(describe);
		modifyRoomType.setId(Integer.parseInt(roomTypeId));
		modifyRoomType.setRoomTypeName(roomTypeName);
		modifyRoomType.setSketch(sketch);
		modifyRoomType.setTypePrice(Double.parseDouble(typePrice));
		if(roomTypeService.modifyRoomType_ById(modifyRoomType)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	
	/*
	 * 添加房间类型(ajax)
	 */
	@RequestMapping(value="/addRoomTypeAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object addRoomTypeAjax(@RequestParam(value="roomImgFile",required=false)MultipartFile roomImgFile,
			@RequestParam(value="roomTypeName",required=false)String roomTypeName,
			@RequestParam(value="sketch",required=false)String sketch,
			@RequestParam(value="describe",required=false)String describe,
			@RequestParam(value="typePrice",required=false)String typePrice,
			HttpSession session,HttpServletRequest req){
		String fileName=null;
		File file=null;
		String newRoomImgFile=null;
		if(roomImgFile!=null){
			//1.是否有上传文件
			if(!roomImgFile.isEmpty()){
				//2.设置文件存放路径
				String path=req.getSession().getServletContext().getRealPath("/static/")+File.separator+"admin"+File.separator+"images"+File.separator+"room";
				//3.获取原文件名
				String originalName=roomImgFile.getOriginalFilename();
				//4.判断文件大小
				int size=500000;
				//5.获得文件后缀名
				String suffix=FilenameUtils.getExtension(originalName);
				if(roomImgFile.getSize()>size){
					req.setAttribute("fileError_ROOM", "上传的文件过大,请重新上传!");
				}else if(suffix.equalsIgnoreCase("jpg")||
						suffix.equalsIgnoreCase("jpeg")||
						suffix.equalsIgnoreCase("png")||
						suffix.equalsIgnoreCase("pneg")
						){
					//添加格式为时间戳加随机数
					fileName=System.currentTimeMillis()+RandomUtils.nextInt(1000000)+"_ROOM."+suffix;
					file=new File(path,fileName);
					//如果文件不存在就创建一个
					if(!file.exists()){
						file.mkdirs();
					}
					try {
						roomImgFile.transferTo(file);
						newRoomImgFile="static/admin/images/room/"+fileName;
					} catch (Exception e) {
						req.setAttribute("fileError_ROOM", e.getMessage());
					}
				}else{
					req.setAttribute("fileError_ROOM", "上传的文件后缀不满足,请重新上传!");
				}
			}
		}
		Map<String, String> result=new HashMap<String, String>();
		RoomType roomType=new RoomType();
		roomType.setRoomImg(newRoomImgFile);
		roomType.setDescribe(describe);
		roomType.setRoomTypeName(roomTypeName);
		roomType.setSketch(sketch);
		roomType.setTypePrice(Double.parseDouble(typePrice));
		if(roomTypeService.addRoomType(roomType)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据id删除房型
	 */
	@RequestMapping(value="delRoomTypeAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object delRoomTypeAjax(@RequestParam("roomTypeId")String roomTypeId,
			HttpServletRequest req){
		Map<String, String> result=new HashMap<String, String>();
		//根据文件路径删除
		RoomType roomType=roomTypeService.selRoomType_ById(Integer.parseInt(roomTypeId));
		String filePath=req.getSession().getServletContext().getRealPath("/static/")+File.separator+"admin"+File.separator+"images"+File.separator+"room";
		String typeImgFile=roomType.getRoomImg();
		String fileName=typeImgFile.substring(typeImgFile.length()-22);
		try {
			File file = new File(filePath, fileName);
			//如果文件不存在就创建一个
			if (file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			System.out.println("删除文件操作出错");
			e.printStackTrace();
		}
		//删除该房型的所有房间
		roomService.delRoom_ByRoomTypeId(Integer.parseInt(roomTypeId));
		if(roomTypeService.delRoomType_ById(Integer.parseInt(roomTypeId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据房间id查询房间
	 */
	@RequestMapping(value="/selRoomAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selRoomAjax(@RequestParam String roomId){
		return roomService.selRoom_ById(Integer.parseInt(roomId));
	}
	/*
	 * 添加房间
	 */
	@RequestMapping(value="/addRoomAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object addRoomAjax(@RequestParam("roomCode")String roomCode,
			@RequestParam("roomFloor")String roomFloor,
			@RequestParam("roomState")String roomState,
			@RequestParam("roomTypeId")String roomTypeId
			){
		Map<String, String> result=new HashMap<String, String>();
		Room room=new Room();
		room.setRoomCode(roomCode);
		room.setRoomFloor(roomFloor);
		room.setRoomState(Integer.parseInt(roomState));
		room.setRoomTypeId(Integer.parseInt(roomTypeId));
		if(roomService.addRoom(room)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 修改房间信息
	 */
	@RequestMapping(value="/modifyRoomAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object modifyRoomAjax(@RequestParam("roomId")String roomId,
			@RequestParam("roomCode")String roomCode,
			@RequestParam("roomFloor")String roomFloor,
			@RequestParam("roomState")String roomState,
			@RequestParam("roomTypeId")String roomTypeId
			){
		Map<String, String> result=new HashMap<String, String>();
		Room room=new Room();
		room.setRoomCode(roomCode);
		room.setRoomFloor(roomFloor);
		room.setRoomState(Integer.parseInt(roomState));
		room.setRoomTypeId(Integer.parseInt(roomTypeId));
		room.setId(Integer.parseInt(roomId));
		if(roomService.modifyRoom_ById(room)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 删除房间
	 */
	@RequestMapping(value="/delRoomAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object delRoomAjax(@RequestParam("roomId")String roomId){
		Map<String, String> result=new HashMap<String, String>();
		if(roomService.delRoom_ById(Integer.parseInt(roomId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 查询房间号存不存在
	 */
	@RequestMapping(value="/selRoomCodeAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selRoomCodeAjax(@RequestParam("roomCode")String roomCode){
		Map<String, String> result=new HashMap<String, String>();
		if(roomService.selRoom_ByRoomCode(Integer.parseInt(roomCode))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
}
