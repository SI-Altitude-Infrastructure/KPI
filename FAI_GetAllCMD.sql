USE [KPI]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		William Maraux
-- Create date: 17/07/2018
-- Modif date : 18/07/2018
-- Description:	CF readme.md
-- EXEC [ALTITUDEINFRA\WilliamM].[FAI_GetAllCMD] 'CREATION', 'WIBOX', '', '2018-01-01', ''
-- test diff github
-- =============================================

ALTER PROCEDURE [ALTITUDEINFRA\WilliamM].[FAI_GetAllCMD]
	@typeCMD VARCHAR(30) = '',
	@FAI VARCHAR(50) = '',
	@statut VARCHAR(30) = '',
	@dateMIN VARCHAR(10) = '',
	@dateMAX VARCHAR(10) = ''
AS
BEGIN

	SET NOCOUNT ON;

	SET DATEFORMAT YMD

	DECLARE @SEL NVARCHAR(MAX) = ''
	DECLARE @CPT NVARCHAR(MAX) = ''
	DECLARE @FRM NVARCHAR(MAX) = ''
	DECLARE @WHR NVARCHAR(MAX) = ''
	DECLARE @ORD NVARCHAR(MAX) = ''
	DECLARE @RQT NVARCHAR(MAX) = ''

	--Base de la requete d'affichage
	SET @SEL += 'SELECT C.libelleClient, FL.Donnees, FL.Statut, FL.Erreur, F.DateCreation' + CHAR(13)
	
	--Base du compteur
	SET @CPT += 'SELECT COUNT(*) AS NBCMD' + CHAR(13)

	--Source de donnée
	SET @FRM += 'FROM ICC..ICC_FichiersLignes FL' + CHAR(13)
	SET @FRM += '	INNER JOIN ICC..ICC_Fichiers F' + CHAR(13)
	SET @FRM += '		ON F.ID = FL.IDFichier' + CHAR(13)
	SET @FRM += '	INNER JOIN AI_Extranet..ExtWS_Client C' + CHAR(13)
	SET @FRM += '		ON C.codeClient = F.CodeFAI' + CHAR(13)
	
	--Params
	SET @WHR += 'WHERE 1=1' + CHAR(13)
	SET @WHR += '	AND Donnees LIKE ''COMMANDE;%''' + CHAR(13)

	IF ISNULL(@typeCMD,'') <> ''
	BEGIN 
		SET @WHR += '	AND Donnees LIKE ''%' + @typeCMD + '%''' + CHAR(13)
	END

	IF ISNULL(@FAI,'') <> ''
	BEGIN 
		SET @WHR += '	AND C.libelleClient LIKE ''%' + @FAI + '%''' + CHAR(13)
	END

	IF ISNULL(@statut,'') <> ''
	BEGIN 
		SET @WHR += '	AND FL.Statut LIKE ''%' + @statut + '%''' + CHAR(13)
	END

	IF ISNULL(@dateMIN,'') <> ''
	BEGIN 
		SET @WHR += '	AND F.DateCreation >= ''' + @dateMIN + '''' + CHAR(13)
	END
	
	IF ISNULL(@dateMAX,'') <> ''
	BEGIN 
		SET @WHR += '	AND F.DateCreation <= ''' + @dateMAX + '''' + CHAR(13)
	END

	--Tri	
	SET @ORD += 'ORDER BY C.libelleClient, F.DateCreation DESC' + CHAR(13)

	SET @RQT = @CPT + @FRM + @WHR
	EXEC sp_executesql @RQT
	PRINT @RQT

	SET @RQT = @SEL + @FRM + @WHR + @ORD
	EXEC sp_executesql @RQT
	PRINT @RQT

END