package com.objectifyExample.controllers;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import com.objectifyExample.entities.Register;
import com.objectifyExample.entities.Profile;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.blobstore.FileInfo;
import com.google.appengine.api.blobstore.UploadOptions;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;

public class SaveProfileDetails extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//private final String UPLOAD_DIRECTORY = "/home/agilecrm/profilepic";
	public static final String UPLOAD_CALLBACK = "/saveProfile";
	
	public static final String GCS_BUCKET_NAME = "gs://lateral-faculty-137712.appspot.com";

    private final ServeUrl serveUrl = new ServeUrl();

    private final BlobstoreService blobstore = 
            BlobstoreServiceFactory.getBlobstoreService();

    private final DatastoreService datastore = 
            DatastoreServiceFactory.getDatastoreService();

    private static final Logger log = 
            Logger.getLogger(SaveProfileDetails.class.getName());
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveProfileDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dispatchUploadForm(request, response, null);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// prefer this method over getBlobInfos() or getUploads()
        // when uploading to GCS
        Map<String, List<FileInfo>> uploads = blobstore.getFileInfos(request);
        List<FileInfo> fileInfos = uploads.get("file");
        if (fileInfos == null || fileInfos.size() == 0) {
            dispatchUploadForm(request, response, "No file has been uploaded");
            return;
        }

        // store info about uploaded files in the Datastore for later use
        // in HomeServlet to list all uploaded content so far.
        List<Entity> entities = new ArrayList<Entity>(fileInfos.size());
        for (FileInfo fileInfo : fileInfos) {
            log.info("Processing upload blobkey: " + fileInfo);
            
            Entity ent = new Entity("FileObject", fileInfo.getGsObjectName());
            //Entity ent = new Entity("FileObject");
            ent.setUnindexedProperty("type", fileInfo.getContentType());
            System.out.println(fileInfo);
            System.out.println(fileInfo.getFilename());
            ent.setUnindexedProperty("name", fileInfo.getFilename());
            ent.setUnindexedProperty("size", fileInfo.getSize());
            ent.setProperty("created", fileInfo.getCreation());
            ent.setUnindexedProperty("url", serveUrl.guessServingUrl(fileInfo));
            System.out.println(serveUrl.guessServingUrl(fileInfo)+"===================Rajesh");
            entities.add(ent);
        }

        datastore.put(entities);
        response.sendRedirect("/profile.jsp");
		/*try{
			Profile profile;
			HttpSession session = request.getSession();
			Long id = (Long)session.getAttribute("id");
			Key<Register> idd = Key.create(Register.class, id);
			String address = request.getParameter("address");
			String skypeid = request.getParameter("skypeid");
			profile = new Profile(address,skypeid,idd);
			ObjectifyService.ofy().save().entity(profile).now();
	        response.sendRedirect("/profile.jsp");
	        ObjectifyService.ofy().clear();
		}catch(Exception e){
			e.printStackTrace();
		}*/
	}
	
	protected void dispatchUploadForm(HttpServletRequest req, HttpServletResponse resp, String errorMsg) throws ServletException, IOException {
        UploadOptions opts = UploadOptions.Builder
                .withGoogleStorageBucketName(GCS_BUCKET_NAME);
        String uploadUrl = blobstore.createUploadUrl("/saveProfile", opts);

        req.setAttribute("uploadUrl", uploadUrl);
        if (errorMsg != null) {
        	System.out.println("hereeeeeeeeeeeeee=============");
            req.setAttribute("error", errorMsg);
        }
        resp.sendRedirect("/profile.jsp");
        //req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

}