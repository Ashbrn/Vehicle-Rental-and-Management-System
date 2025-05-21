    </main>
    
    <!-- Footer -->
    <footer class="footer mt-auto">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Vehicle Rental System</h5>
                    <p>Your trusted partner for vehicle rentals. We provide high-quality vehicles at affordable prices.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/" class="text-white fw-bold" style="color: #ffffff !important; text-decoration: underline !important;">Home</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/vehicles" class="text-white fw-bold" style="color: #ffffff !important; text-decoration: underline !important;">Vehicles</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/about" class="text-white fw-bold" style="color: #ffffff !important; text-decoration: underline !important;">About Us</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/contact" class="text-white fw-bold" style="color: #ffffff !important; text-decoration: underline !important;">Contact Us</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <address>
                        <i class="fas fa-map-marker-alt me-2"></i> NIET, Plot 19, Knowledge Park 2, Greater Noida<br>
                        <i class="fas fa-phone me-2"></i> +91 98765 43210<br>
                        <i class="fas fa-envelope me-2"></i> info@indianvehiclerental.com
                    </address>
                </div>
            </div>
            <hr class="bg-light">
            <div class="text-center">
                <p>&copy; 2025 Indian Vehicle Rental System. All rights reserved.</p>
            </div>
        </div>
    </footer>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Auto-hide success and error alerts after 5 seconds, but keep info alerts
        $(document).ready(function() {
            setTimeout(function() {
                $(".alert-success, .alert-danger").alert('close');
            }, 5000);
            
            // Make sure footer links work
            $(".footer a").on('click', function(e) {
                var href = $(this).attr('href');
                if (href) {
                    window.location.href = href;
                }
            });
        });
    </script>
</body>
</html>