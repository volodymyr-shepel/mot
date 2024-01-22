package com.mot.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mot.dtos.AnonymousNotificationDTO;
import com.mot.dtos.CreateThreadDTO;
import com.mot.dtos.SendNotificationDTO;
import com.mot.models.Notification;
import com.mot.models.Thread;
import com.mot.repository.NotificationRepository;
import com.mot.repository.ThreadRepository;
import com.mot.util.NotificationStatus;
import com.mot.util.NotificationType;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.UUID;

@Service
@Slf4j
public class NotificationService {
    private final JavaMailSender javaMailSender;

    @Value("${app.email-from}")
    private String emailSender;

    @Value("${app.email-from-name}")
    private String emailSenderName;

    private final TemplateEngine templateEngine;
    private final NotificationRepository notificationRepository;
    private final ThreadRepository threadRepository;

    @Autowired
    public NotificationService(JavaMailSender javaMailSender, TemplateEngine templateEngine, NotificationRepository notificationRepository, ThreadRepository threadRepository) {
        this.javaMailSender = javaMailSender;
        this.templateEngine = templateEngine;
        this.notificationRepository = notificationRepository;
        this.threadRepository = threadRepository;
    }

    @Async
    public void sendNotification(AnonymousNotificationDTO notification) {
        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

            helper.setText(generateEmailContent(notification.notificationFields(), notification.notificationType()), true);
            helper.setTo(notification.recipient());
            helper.setSubject(notification.subject());
            helper.setFrom(emailSender, emailSenderName);
            javaMailSender.send(mimeMessage);

            ResponseEntity.ok("The email has been sent successfully");
        } catch (MessagingException | UnsupportedEncodingException e) {
            log.error("Check connection, error occurred");
            ResponseEntity.badRequest().body("Error occurred when sending an email");
        }


    }

    @Async
    @Transactional
    public void sendNotification(SendNotificationDTO notification) {

        try {
            Thread thread = threadRepository.getReferenceById(notification.threadId());

            if (thread == null) {
                throw new NoSuchElementException("Thread id is wrong!");
            }

            Notification notification_ = Notification.of(notification, thread);
            notification_.setNotificationStatus(NotificationStatus.DELIVERED);
            notificationRepository.saveAndFlush(notification_);
            log.info("Notification send trial");
            sendNotification(AnonymousNotificationDTO.of(thread, notification));
            log.info("Success");
        } catch (JsonProcessingException e) {
            ResponseEntity.badRequest().body("Error occurred when creating message!");
        } catch (NoSuchElementException e) {
            ResponseEntity.badRequest().body("Thread id is wrong!");

        }

    }

    @Transactional
    public UUID createThread(CreateThreadDTO threadDTO) {
        return threadRepository.saveAndFlush(Thread.of(threadDTO)).getId();
    }


    private String generateEmailContent(Map<String, String> fields, NotificationType notificationType){
        Context context = new Context();
        // set placeholders inside the template
        for(Map.Entry<String, String> entry : fields.entrySet()){
            context.setVariable(entry.getKey(), entry.getValue());
        }
        // since the template name is lowercase of notificationType
        String templateName = notificationType.toString().toLowerCase();

        // return the email content with already filled placeholders
        return templateEngine.process(templateName, context);
    }
}