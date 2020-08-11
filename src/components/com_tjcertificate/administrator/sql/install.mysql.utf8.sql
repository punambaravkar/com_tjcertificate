CREATE TABLE IF NOT EXISTS `#__tj_certificate_templates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `unique_code` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `template_css` text NULL,
  `client` varchar(100) NOT NULL COMMENT 'e.g. com_jticketing.event, com_tjlms.course',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(3) NOT NULL,
  `checked_out` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_public` tinyint(1) NOT NULL COMMENT '1-Private, 2-Public',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY unqk_code (`unique_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `#__tj_certificate_issue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unique_certificate_id` varchar(150) NOT NULL,
  `certificate_template_id` int(11) NOT NULL,
  `generated_body` text NOT NULL,
  `client` varchar(100) NOT NULL,
  `client_id` int(11) NOT NULL,
  `client_issued_to` int(11) NOT NULL,
  `client_issued_to_name` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NULL,
  `state` tinyint(3) NOT NULL,
  `issued_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expired_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY unqk_certificate_id (`unique_certificate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;
