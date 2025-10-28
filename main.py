from fastapi import FastAPI, Form, Request, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from baml_client import b
import uvicorn
from pydantic import BaseModel
from datetime import datetime
from dotenv import load_dotenv
import logging

load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class ScrumUpdateRequest(BaseModel):
    input_data: str

def create_app():
    app = FastAPI(title="Scrum Update Processor")
    
    # Initialize templates
    templates = Jinja2Templates(directory="templates")

    @app.get("/", response_class=HTMLResponse)
    async def read_root(request: Request):
        """Serve the main HTMX interface"""
        return templates.TemplateResponse("index.html", {"request": request})

    @app.post("/process-scrum", response_class=HTMLResponse)
    async def process_scrum_htmx(request: Request, input_data: str = Form(...)):
        """Process scrum update and return HTML fragment for HTMX"""
        try:
            current_date = datetime.now().strftime("%Y-%m-%d")
            logger.info(f"Processing scrum update for date: {current_date}")
            
            # Call the BAML function
            result = b.ExtractScrumUpdate(input_data, current_date)
            
            return templates.TemplateResponse("scrum_response.html", {
                "request": request,
                "scrum_update": result
            })
        except Exception as e:
            logger.error(f"Error processing scrum update: {str(e)}")
            return templates.TemplateResponse("scrum_response.html", {
                "request": request,
                "error": f"Failed to process scrum update: {str(e)}"
            })

    @app.post("/scrum-update")
    async def process_scrum_update_json(request: ScrumUpdateRequest):
        """Original JSON API endpoint for backward compatibility"""
        try:
            current_date = datetime.now().strftime("%Y-%m-%d")
            result = b.ExtractScrumUpdate(request.input_data, current_date)
            return result
        except Exception as e:
            logger.error(f"Error in JSON API: {str(e)}")
            raise HTTPException(status_code=500, detail=str(e))

    @app.get("/health")
    async def health_check():
        """Health check endpoint"""
        return {"status": "healthy", "service": "Scrum Update Processor"}

    return app

def main():
    app = create_app()
    print("🚀 Starting Scrum Update HTMX Server...")
    print("📱 Open your browser to: http://localhost:8000")
    print("🔗 API documentation at: http://localhost:8000/docs")
    
    uvicorn.run(app, host="0.0.0.0", port=8000, log_level="info")

if __name__ == "__main__":
    main()
