<?php
/**
 * @package     TJCertificate
 * @subpackage  com_tjcertificate
 *
 * @author      Techjoomla <extensions@techjoomla.com>
 * @copyright   Copyright (C) 2009 - 2019 Techjoomla. All rights reserved.
 * @license     http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

// No direct access to this file
defined('_JEXEC') or die('Restricted access');

use Joomla\CMS\MVC\Controller\FormController;
use Joomla\CMS\Factory;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Router\Route;

/**
 * The certificate controller
 *
 * @since  1.0.0
 */
class TjCertificateControllerCertificate extends FormController
{
	/**
	 * Method to download issued certificate.
	 *
	 * @return  boolean|string Certificate pdf url.
	 *
	 * @since 1.0
	 */
	public function download()
	{
		$user  = Factory::getUser();
		$app   = Factory::getApplication();
		$input = $app->input;

		if (!$user->id)
		{
			$app->enqueueMessage(Text::_('COM_TJCERTIFICATE_ERROR_LOGIN_MESSAGE'), 'error');
			$url      = base64_encode(JUri::getInstance()->toString());
			$loginUrl = Route::_('index.php?option=com_users&view=login&return=' . $url, false);
			$app->redirect($loginUrl);
		}

		$uniqueCertificateId = $input->get('certificate', '');

		// Download for sending it in email
		$store = $input->get('store', '');

		if (empty($uniqueCertificateId))
		{
			$app->enqueueMessage(Text::_('COM_TJCERTIFICATE_ERROR_CERTIFICATE_EMPTY'), 'error');
			$app->redirect('index.php');
		}

		$certificateObj = TJCERT::Certificate()::validateCertificate($uniqueCertificateId);

		if (!$certificateObj->id)
		{
			$app->enqueueMessage(Text::_('COM_TJCERTIFICATE_ERROR_CERTIFICATE_EXPIRED'), 'error');
			$app->redirect('index.php');
		}

		echo $certificateObj->pdfDownload($store);
	}
}
