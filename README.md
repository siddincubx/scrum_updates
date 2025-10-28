# 🏃‍♂️ Scrum Update Processor with HTMX

An interactive web application that uses AI to extract structured information from scrum meeting transcripts using HTMX for seamless user experience.

## 🌟 Features

- **HTMX-powered interface** - No page reloads, instant responses
- **AI-powered extraction** - Uses BAML and Gemini AI to process transcripts
- **Multiple input formats** - Supports meeting transcripts, chat messages, email threads
- **Structured output** - Extracts date, summary, accomplishments, plans, sentiments, blockers, speakers, and duration
- **Clean responsive design** - Mobile-friendly interface

## 🚀 Quick Start

### Prerequisites
- Python 3.13+
- GEMINI_API_KEY environment variable

### Installation & Running

1. **Clone and enter the directory**:
   ```bash
   cd scrum_updates
   ```

2. **Set up environment**:
   ```bash
   # Create virtual environment (if not already created)
   python -m venv .venv
   
   # Activate virtual environment
   .venv\Scripts\activate  # Windows
   # or
   source .venv/bin/activate  # Linux/Mac
   ```

3. **Install dependencies**:
   ```bash
   pip install -r pyproject.toml
   # or manually:
   pip install fastapi uvicorn jinja2 python-multipart baml-py python-dotenv
   ```

4. **Set up API key**:
   Create a `.env` file with your Gemini API key:
   ```
   GEMINI_API_KEY=your_api_key_here
   ```

5. **Run the server**:
   ```bash
   python main.py
   ```

6. **Open in browser**:
   Navigate to: http://localhost:8000

## 🎯 How to Use

1. **Load the web interface** at http://localhost:8000
2. **Enter your scrum data** in the text area:
   - Meeting transcripts with timestamps
   - Slack/Teams conversation exports
   - Email thread copies
   - Bullet-point meeting notes
3. **Click "Process Scrum Update"** or use the sample data button
4. **View the extracted information** displayed below (powered by HTMX)

## 🛠️ API Endpoints

### Web Interface
- `GET /` - Main HTMX interface
- `POST /process-scrum` - Process transcript and return HTML fragment

### JSON API
- `POST /scrum-update` - Original JSON API endpoint
- `GET /health` - Health check

### Example JSON API Usage
```bash
curl -X POST "http://localhost:8000/scrum-update" \
     -H "Content-Type: application/json" \
     -d '{"input_data": "Your transcript here..."}'
```

## 🏗️ Architecture

- **FastAPI** - Web framework
- **HTMX** - Frontend interactivity without JavaScript
- **Jinja2** - Template engine
- **BAML** - AI function orchestration
- **Gemini AI** - Language model for extraction

## 📂 Project Structure

```
scrum_updates/
├── main.py                 # FastAPI application
├── templates/
│   ├── index.html         # Main HTMX interface
│   └── scrum_response.html # Response template
├── baml_client/           # Generated BAML client
├── baml_src/              # BAML function definitions
├── .env                   # Environment variables
└── pyproject.toml         # Dependencies
```

## 🔧 Technical Details

### HTMX Integration
- Uses `hx-post` for form submission
- `hx-target` to update response container
- `hx-indicator` for loading states
- Returns HTML fragments instead of full pages

### AI Processing
- BAML function `Extract_scrum_update` processes input
- Extracts: date, summary, accomplishments, plans, sentiments, blockers, speakers, duration
- Uses Gemini 2.0 Flash Lite model for fast processing

### Error Handling
- Graceful error display in the UI
- Logging for debugging
- Fallback error responses

## 🎨 Customization

- Modify `templates/index.html` for UI changes
- Update `baml_src/scrum_updates.baml` for different extraction fields
- Adjust styling in the `<style>` section of templates

## 📝 Example Input/Output

**Input:**
```
Priya 9:30 AM
Morning folks, let's do a quick sync. How's everyone doing?

Raj 9:31 AM
Hey all. I wrapped up the backend logic for the payment gateway yesterday...
```

**Output:**
- Date: 2024-10-28
- Summary: Team sync on payment gateway progress
- Accomplishments: Backend logic completed, tests passing
- Plans: API development, mobile component fixes
- Sentiments: Positive team collaboration
- Blockers: CSS mobile responsiveness issues
- Speakers: Priya, Raj, Anjali, Samir
- Duration: 11 minutes

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is open source and available under the MIT License.
