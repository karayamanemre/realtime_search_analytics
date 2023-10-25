articles_data = [
  { title: "Ruby on Rails Basics", content: "Learn the basics of Ruby on Rails, the popular web development framework. Understand MVC, routes, migrations, and views." },
  { title: "Advanced JavaScript Techniques", content: "Dive deep into closures, promises, async/await, and other advanced concepts in JavaScript." },
  { title: "Machine Learning with Python", content: "Python is a favorite for machine learning. Discover libraries like TensorFlow, Keras, and PyTorch." },
  { title: "Web Design for Beginners", content: "Understanding the basics of HTML, CSS, and responsive design. Create beautiful websites with ease." },
  { title: "Database Optimization", content: "Learn about normalization, indexing, and other techniques to speed up your database queries and operations." },
  { title: "Mobile App Development with React Native", content: "React Native allows you to write mobile apps using JavaScript. Explore the fundamentals and advanced topics." },
  { title: "Distributed Systems and Microservices", content: "Break apart your monolith! Understand the principles behind distributed systems and how to architect your services." },
  { title: "DevOps and Continuous Deployment", content: "Streamline your development process with CI/CD. Learn tools like Jenkins, Travis CI, and Docker." },
  { title: "Cybersecurity Fundamentals", content: "Protect your systems from malicious attacks. Understand common vulnerabilities and how to defend against them." },
  { title: "Game Development with Unity", content: "Design and develop video games using Unity. Understand physics, graphics, and scripting to create interactive experiences." }
]

articles_data.each do |article_data|
  Article.create(title: article_data[:title], content: article_data[:content])
end

puts "10 diverse articles created."