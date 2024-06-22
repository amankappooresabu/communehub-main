from flask import Flask, request, jsonify
import spacy
import numpy as np
import firebase_admin
from firebase_admin import credentials, firestore

# Load the spaCy model
nlp = spacy.load("en_core_web_md")

app = Flask(__name__)

# Initialize Firebase Admin with your service account key
firebase_admin.initialize_app(cred, name='CommuneHub')  # Use a unique app name

@app.route('/submit', methods=['POST'])
def submit():
    try:
        # Get user data from the request JSON
        user_data = request.json
        
        print("Received user data:", user_data)  # Debug statement

        # Extract user data using correct keys
        previous_positions_input = user_data.get('previousPositions', '')
        aptitude_input = user_data.get('aptitude', '')
        volunteering_experiences_input = user_data.get('volunteering', '')  # Corrected key
        what_would_you_do_differently_input = user_data.get('whatWouldYouDoDifferently', '')  # Corrected key

        print("Previous positions input:", previous_positions_input)  # Debug statement
        print("Aptitude input:", aptitude_input)  # Debug statement
        print("Volunteering experiences input:", volunteering_experiences_input)  # Debug statement
        print("What would you do differently input:", what_would_you_do_differently_input)  # Debug statement

        # Process input sentences and obtain word vectors
        previous_positions_vector = nlp(previous_positions_input).vector
        aptitude_vector = nlp(aptitude_input).vector
        volunteering_experiences_vector = nlp(volunteering_experiences_input).vector
        what_would_you_do_differently_vector = nlp(what_would_you_do_differently_input).vector

        print("Previous positions vector:", previous_positions_vector)  # Debug statement
        print("Aptitude vector:", aptitude_vector)  # Debug statement
        print("Volunteering experiences vector:", volunteering_experiences_vector)  # Debug statement
        print("What would you do differently vector:", what_would_you_do_differently_vector)  # Debug statement

        # Define the perfect answer vectors for previous positions, aptitude, volunteering experiences, and what would you do differently
        perfect_previous_positions_answer = nlp("Previous positions held: IEEE Web Lead, CSI Web Lead, and GDSC Web Lead. Managed website functionality, security, and user experience. Led teams in development and optimization, gaining valuable web development and leadership skills.").vector
        perfect_aptitude_answer = nlp("I am highly capable for this position due to my strong leadership skills and extensive experience in managing web development projects. As a web lead for IEEE, CSI, and GDSC, I have successfully managed website functionality, security, and user experience. I am adept at leading teams in development and optimization, and I am eager to contribute these skills to your team.").vector
        perfect_volunteering_experiences_answer = nlp("I have actively participated in various web development projects, including my involvement in the Asthra web team where I contributed to the creation of event websites. Additionally, I have dedicated my efforts to supporting initiatives within the IEEE Kerala section, notably contributing to events like AKSC. Through these experiences, I have honed my skills in web development, teamwork, and project management, while also demonstrating a commitment to community and professional development.").vector
        perfect_what_would_you_do_differently_answer = nlp("If chosen for the web team, I'd prioritize teamwork and innovation. I'd encourage regular brainstorming sessions, adopt agile methodologies for efficiency, and organize skill-sharing workshops. Communication would be transparent, with regular updates and feedback sessions. Seeking input from stakeholders and users would ensure our work meets their needs. Overall, I'd foster a culture of collaboration, continuous learning, and user-centricity for exceptional results.").vector

        # Calculate cosine similarity between user input vectors and perfect answer vectors
        def calculate_similarity(user_vector, perfect_answer_vector):
            user_norm = np.linalg.norm(user_vector)
            perfect_answer_norm = np.linalg.norm(perfect_answer_vector)
            if user_norm == 0 or perfect_answer_norm == 0:
                return 0
            return np.dot(user_vector, perfect_answer_vector) / (user_norm * perfect_answer_norm)

        previous_positions_similarity = calculate_similarity(previous_positions_vector, perfect_previous_positions_answer)
        aptitude_similarity = calculate_similarity(aptitude_vector, perfect_aptitude_answer)
        volunteering_experiences_similarity = calculate_similarity(volunteering_experiences_vector, perfect_volunteering_experiences_answer)
        what_would_you_do_differently_similarity = calculate_similarity(what_would_you_do_differently_vector, perfect_what_would_you_do_differently_answer)

        # Scale the similarity scores to a range of 0 to 100
        previous_positions_score = round(previous_positions_similarity * 100)
        aptitude_score = round(aptitude_similarity * 100)
        volunteering_experiences_score = round(volunteering_experiences_similarity * 100)
        what_would_you_do_differently_score = round(what_would_you_do_differently_similarity * 100)

        # Calculate the average score
        average_score = round((previous_positions_score + aptitude_score + volunteering_experiences_score + what_would_you_do_differently_score) / 4)

        # Store scores in Firebase Firestore
        identifier = user_data.get('identifier', '')  # Get user's email as identifier
        db = firestore.client(app=firebase_admin.get_app(name='CommuneHub'))  # Get Firestore client for the specified app
        doc_ref = db.collection('execom_scores').document(identifier)
        doc_ref.set({
            'previous_positions_score': previous_positions_score,
            'aptitude_score': aptitude_score,
            'volunteering_experiences_score': volunteering_experiences_score,
            'what_would_you_do_differently_score': what_would_you_do_differently_score,
            'average_score': average_score
        })

        # Construct JSON response with scores and success message
        response_data = {
            'previous_positions_score': previous_positions_score,
            'aptitude_score': aptitude_score,
            'volunteering_experiences_score': volunteering_experiences_score,
            'what_would_you_do_differently_score': what_would_you_do_differently_score,
            'average_score': average_score,
            'message': 'Data received and processed successfully'
        }

        return jsonify(response_data)

    except Exception as e:
        print("Error:", e)
        return jsonify({'error': str(e)}), 500
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
